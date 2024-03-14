use ig_clone;
-- q.1 Create an ER diagram or draw a schema for the given database.
-- s1: done
-- q.2 We want to reward the user who has been around the longest, Find the 5 oldest users
SELECT 
    *
FROM
    users
ORDER BY created_at
LIMIT 5;

-- q.3 To target inactive users in an email ad campaign, find the users who have never posted a photo.
SELECT 
    id, username
FROM
    users
WHERE
    id NOT IN (SELECT DISTINCT
            user_id
        FROM
            photos)
GROUP BY id;

-- q.4 Suppose you are running a contest to find out who got the most likes on a photo. Find out who won?
SELECT 
    COUNT(user_id), photo_id
FROM
    likes
GROUP BY photo_id
ORDER BY COUNT(user_id) DESC
LIMIT 1;

-- q.5 The investors want to know how many times does the average user post.
SELECT 
    *
FROM
    photos;
SELECT 
    user_id, AVG(post_count)
FROM
    (SELECT 
        user_id, COUNT(image_url) AS post_count
    FROM
        photos
    GROUP BY user_id) AS user_post_count
GROUP BY user_id;

-- q.6 A brand wants to know which hashtag to use on a post, and find the top 5 most used hashtags.

SELECT 
    tag_name
FROM
    tags
WHERE
    id IN (SELECT 
            tag_id
        FROM
            photo_tags
        GROUP BY tag_id
        ORDER BY COUNT(photo_id) DESC)
LIMIT 5;

-- q.7 To find out if there are bots, find users who have liked every single photo on the site.
SELECT 
    user_id
FROM
    (SELECT 
        user_id, COUNT(DISTINCT photo_id) AS photo_count
    FROM
        likes
    GROUP BY user_id) AS user_likes
WHERE
    photo_count = (SELECT 
            COUNT(DISTINCT id)
        FROM
            photos);

-- q.8 Find the users who have created instagramid in may and select top 5 newest joinees from it?
SELECT 
    *
FROM
    users;
SELECT 
    username, created_at
FROM
    users
WHERE
    MONTH(created_at) = 5
ORDER BY created_at DESC
LIMIT 5;

-- q.9 Can you help me find the users whose name starts with c and ends with any number 
-- and have posted the photos as well as liked the photos?
-- solution:
SELECT 
    u.id, u.username
FROM
    users u
        INNER JOIN
    (SELECT DISTINCT
        p.user_id
    FROM
        photos p
    INNER JOIN likes l ON p.user_id = l.user_id) AS pl ON u.id = pl.user_id
WHERE
    username REGEXP '^c.*[0-9]$';

-- q.10 Demonstrate the top 30 usernames to the company who have posted photos in the range of 3 to 5
SELECT 
    u.username, COUNT(p.image_url) AS image_count
FROM
    users u
        INNER JOIN
    photos p ON u.id = p.user_id
GROUP BY u.id
HAVING image_count BETWEEN 3 AND 5
ORDER BY image_count
LIMIT 30;
