From: Marcus Sorensen <shadowsor@gmail.com>
Subject: Re: radosgw: "MethodNotAllowed" response for AWS C# Sample
Date: Wed, 23 Jan 2013 18:20:15 -0700
Message-ID: <CALFpzo5KHfc3F7uBw0zHS7AZks_eekhKOS2Zs03Ob7_xoLNpiQ@mail.gmail.com>
References: <CAJVE5RWMk8sbeLt52OuV+18aZeDa4J5x48x1bLyjSqT8RE4apw@mail.gmail.com>
	<CAC-hyiF5j_V4_Oou_6JSkDTBJzWLxWb+W=w_7YWhrEuv5WO8BQ@mail.gmail.com>
	<CALFpzo54uEU739sb6JEXc+toP7bcBkYihGOtgiUqo48b2XHwnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:51711 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752283Ab3AXBZ1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Jan 2013 20:25:27 -0500
Received: by mail-vc0-f174.google.com with SMTP id n11so6167632vch.5
        for <ceph-devel@vger.kernel.org>; Wed, 23 Jan 2013 17:25:26 -0800 (PST)
In-Reply-To: <CALFpzo54uEU739sb6JEXc+toP7bcBkYihGOtgiUqo48b2XHwnQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: Cesar Mello <cmello@gmail.com>, ceph-devel@vger.kernel.org

Re-sending this due to plain text limitations:

Are you just testing a build following the 5 min guide? I did this
today, and the "method not allowed" just meant that apache wasn't
acutally set up to call rados gateway via rewrite. I verified this by
placing an index.html in /var/www and seeing that I was able to see
that page. If you're using the quick guide
(http://ceph.com/docs/master/start/quick-rgw/), what I did to fix my
issue was change a bit in the supplied apache rgw.conf from this:

</VirtualHost>

RewriteEngine On
RewriteRule ^/([a-zA-Z0-9-_.]*)([/]?.*)
/s3gw.fcgi?page=$1&params=$2&%{QUERY_STRING}
[E=HTTP_AUTHORIZATION:%{HTTP:Authorization},L]

<VirtualHost *:80>

to this:

#</VirtualHost>

RewriteEngine On
RewriteRule ^/([a-zA-Z0-9-_.]*)([/]?.*)
/s3gw.fcgi?page=$1&params=$2&%{QUERY_STRING}
[E=HTTP_AUTHORIZATION:%{HTTP:Authorization},L]

#<VirtualHost *:80>


> On Wed, Jan 23, 2013 at 5:51 PM, Yehuda Sadeh <yehuda@inktank.com> wrote:
>>
>> On Wed, Jan 23, 2013 at 4:46 PM, Cesar Mello <cmello@gmail.com> wrote:
>> > Hi,
>> >
>> > When running the PutObject sample from
>> > http://ceph.com/docs/master/radosgw/s3/csharp/ I get a
>> > "MethodNotAllowed" response. Please has anyone successfully run this
>> > sample?
>> >
>> > I have tested with a current local build (0.56).
>> >
>>
>> Is there anything in the radosgw log? in the apache access, error
>> logs? It might be that your apache has some other (maybe default) site
>> configured to handle requests, and it doesn't really reach radosgw.
>>
>> Yehuda
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
