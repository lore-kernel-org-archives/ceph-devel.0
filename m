From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: JSON generation in C/C++
Date: Mon, 1 Aug 2011 09:24:50 -0700
Message-ID: <CAORUGqA91fXDjUSB-YT+5_C6d0Ap8SE7kqcKKZvt4or-VxuTPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:57273 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753041Ab1HAQZM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Aug 2011 12:25:12 -0400
Received: by vxh35 with SMTP id 35so4276379vxh.19
        for <ceph-devel@vger.kernel.org>; Mon, 01 Aug 2011 09:25:11 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

We've talked about generating/parsing JSON a few times, and how we've
run into edge cases whenever we've rolled our own functions for that.
I've mentioned this C library a few times, but I'm not sure if I've
actually sent the link to anyone.. Here's a C library for
generating/parsing JSON, written by an ex-cow-orker of mine.

One feedback I've received earlier was that the "DOM-style"
architecture, where you build up the JSON object in-memory and then
dump it out, is not always a good match. If you want to avoid that,
you can pull off a trick like this pseudocode:

write("{")
json.dump(key)
write(":")
json.dump(value)
write(",")
json.dump(key2)
write(":")
json.dump(value2)
write("}")

The above still uses the library for proper string encoding etc, while
letting you control the top-level structure explicitly. And it should
be pretty easy to encapsulate the above in a convenience wrapper, to
make streaming even nicer; something like this pseudocode:

j = StreamingJSONObject(fd)
j.dump(key, value)
j.dump(key2, value2)
j.close()
