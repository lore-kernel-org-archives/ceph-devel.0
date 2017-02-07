From: kefu chai <tchaikov@gmail.com>
Subject: Re: Manpages install location
Date: Wed, 8 Feb 2017 02:11:50 +0800
Message-ID: <CAJE9aOMQKaWfzNteKxHFnMSJUJayvATKyR4vj_qmGKSz_owFmA@mail.gmail.com>
References: <2d9ab045-26cf-d178-79af-7f389d2f3b8b@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f176.google.com ([209.85.217.176]:35556 "EHLO
        mail-ua0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753961AbdBGSLw (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Feb 2017 13:11:52 -0500
Received: by mail-ua0-f176.google.com with SMTP id y9so91173189uae.2
        for <ceph-devel@vger.kernel.org>; Tue, 07 Feb 2017 10:11:52 -0800 (PST)
In-Reply-To: <2d9ab045-26cf-d178-79af-7f389d2f3b8b@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

+ ceph-devel

On Tue, Feb 7, 2017 at 5:41 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> Hi Kefu,
>
> Do you have a hint on where to modify the install location for the
> manpages...
>
> They now end in /usr/local/man/man8 ...

doc/man/8/CMakeLists.txt

```
  install(FILES ${sphinx_output_dir}/${cmd}.8
    DESTINATION ${CEPH_MAN_DIR}/man8)
```

you need to conditionalize the DESTINATION arg.

> And FreeBSD has the packages man pages in /usr/local/man/

i think the manpages of section#8 installed by ports should go to
/usr/local/man/man8. see
https://www.freebsd.org/cgi/man.cgi?query=hier&apropos=0&sektion=0&manpath=FreeBSD+12-current&arch=default&format=html.
for example, wget's manpage is located at
/usr/local/man/man1/wget.1.gz

>
> 2nd thing is that I prefer to gzip them, but that is not super
> essential. But most of the others are compressed.


you might need to add an add_custom_command() and conditionalize the
install() function to the loop of "foreach(man ${man_srcs})" to
install the gzipped man pages for FreeBSD. please be sure to
`find_program(GZIP gzip)` before using "gzip".

>
> Thanx,
> --WjW



-- 
Regards
Kefu Chai
