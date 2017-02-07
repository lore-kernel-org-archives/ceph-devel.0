From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Manpages install location
Date: Tue, 7 Feb 2017 23:18:36 +0100
Message-ID: <7e1572a0-2df2-85c0-dd1a-68c35f895ff3@digiware.nl>
References: <2d9ab045-26cf-d178-79af-7f389d2f3b8b@digiware.nl>
 <CAJE9aOMQKaWfzNteKxHFnMSJUJayvATKyR4vj_qmGKSz_owFmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:63284 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932101AbdBGWSn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 7 Feb 2017 17:18:43 -0500
In-Reply-To: <CAJE9aOMQKaWfzNteKxHFnMSJUJayvATKyR4vj_qmGKSz_owFmA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 7-2-2017 19:11, kefu chai wrote:
> + ceph-devel
> 
> On Tue, Feb 7, 2017 at 5:41 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>> Hi Kefu,
>>
>> Do you have a hint on where to modify the install location for the
>> manpages...
>>
>> They now end in /usr/local/man/man8 ...

I meant to write /usr/local/share/man/man8. Which is an odd mix of what
goes under Linux and FreeBSD packages.

> 
> doc/man/8/CMakeLists.txt
> 
> ```
>   install(FILES ${sphinx_output_dir}/${cmd}.8
>     DESTINATION ${CEPH_MAN_DIR}/man8)
> ```

Ah, I looked there, but obviously not deep enough in the tree.

> you need to conditionalize the DESTINATION arg.
> 
>> And FreeBSD has the packages man pages in /usr/local/man/
>
> i think the manpages of section#8 installed by ports should go to
> /usr/local/man/man8. see
> https://www.freebsd.org/cgi/man.cgi?query=hier&apropos=0&sektion=0&manpath=FreeBSD+12-current&arch=default&format=html.
> for example, wget's manpage is located at
> /usr/local/man/man1/wget.1.gz

Yup, that is where I copy them right now in the ports Makefile.

>>
>> 2nd thing is that I prefer to gzip them, but that is not super
>> essential. But most of the others are compressed.
> 
> 
> you might need to add an add_custom_command() and conditionalize the
> install() function to the loop of "foreach(man ${man_srcs})" to
> install the gzipped man pages for FreeBSD. please be sure to
> `find_program(GZIP gzip)` before using "gzip".

I'll have a shot at it.

Thanx,
--WjW
