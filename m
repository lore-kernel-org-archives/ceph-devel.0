From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: RGW: Refusing FastCGI request with empty CONTENT_LENGTH ? Why ?
Date: Tue, 2 Apr 2013 15:03:43 +0200
Message-ID: <CAF6-1L6y81uVN29ZJyjxOHv5r=cQXqoYdSV22AGHY1U9Xgu57g@mail.gmail.com>
References: <CAF6-1L4GdD8w=3y-0fnVHLA1RPAoKmr-EwST9_pteD_i8opkPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f52.google.com ([209.85.214.52]:37304 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760561Ab3DBNDp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Apr 2013 09:03:45 -0400
Received: by mail-bk0-f52.google.com with SMTP id it16so195915bkc.25
        for <ceph-devel@vger.kernel.org>; Tue, 02 Apr 2013 06:03:44 -0700 (PDT)
In-Reply-To: <CAF6-1L4GdD8w=3y-0fnVHLA1RPAoKmr-EwST9_pteD_i8opkPw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,


In src/rgw/rgw_rest.cc you can find :

if (s->length) {
  if (*s->length == '\0')
    return -EINVAL;
  s->content_length = atoll(s->length);
}

So that means if there is a CONTENT_LENGTH field in the environment
but it's empty, then the request is just refused.

Why ?

As it turns out, nginx does send an empty CONTENT_LENGTH params ...
which means it doesn't work at all of course.


Cheers,

     Sylvain
