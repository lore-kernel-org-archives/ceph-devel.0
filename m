From: Kelly Kane <kelly@hawknetworks.com>
Subject: Re: RPMs on build.opensuse.org
Date: Tue, 11 Oct 2011 12:45:03 -0700
Message-ID: <CAKfXD0zvW4+C_ohi1onQ4ukbduXVOqg5AcOKMw7uTzZqxJBfxA@mail.gmail.com>
References: <Pine.LNX.4.64.1110041025030.23052@cobra.newdream.net>
	<201110071216.12793.cndegen@suse.de>
	<Pine.LNX.4.64.1110092117360.26432@cobra.newdream.net>
	<4E928DFD.40803@suse.de>
	<Pine.LNX.4.64.1110101937300.7288@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:41971 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754933Ab1JKTpF convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Oct 2011 15:45:05 -0400
Received: by ggnv2 with SMTP id v2so6058118ggn.19
        for <ceph-devel@vger.kernel.org>; Tue, 11 Oct 2011 12:45:03 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1110101937300.7288@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Hannes Reinecke <hare@suse.de>, ceph-devel@vger.kernel.org, Christian Degen <cndegen@suse.de>, PChadwick@suse.com, dona.holmberg@dreamhost.com, Bryan Bogensberger <bryan@newdream.net>

On Mon, Oct 10, 2011 at 19:41, Sage Weil <sage@newdream.net> wrote:
>>
>> The insserv thing is easy to workaround; just don't enable service c=
eph when
>> installing the package :-)
>
> Hmm, yeah... Is that the right thing to do though? =C2=A0Don't RPMs n=
ormally
> enable the serve when you install them?

I think it is up to the package developer. For example on CentOS 5.4
lighttpd and httpd do not start themselves, but I know the MySQL
Community packages do start themselves. I know with MySQL I also
always wind up immediately stopping it after it's installed to do
configuration. As configuration of any given Ceph node is likely to be
part of a larger configuration management/automation system it seems
like it would be fine to push responsibility of "service ceph start"
off onto the system administrators. I would still configure it to
start automatically on boot in the rpm.

Kelly
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
