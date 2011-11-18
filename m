From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: phprados update
Date: Fri, 18 Nov 2011 13:05:39 -0800
Message-ID: <CAORUGqCmd0NJBmo-UPXwb-np1Wnk-1kpJzgP0h=8iD_4qLAGPA@mail.gmail.com>
References: <4EC68B82.9020106@widodh.nl> <CAORUGqBXO_Wq3RszYgYETd2VJRHsGguMXJ2D8FuewbKWorSG8w@mail.gmail.com>
 <4EC6C76F.40700@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:32938 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105Ab1KRVGB convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Nov 2011 16:06:01 -0500
Received: by wwe5 with SMTP id 5so5926849wwe.1
        for <ceph-devel@vger.kernel.org>; Fri, 18 Nov 2011 13:06:00 -0800 (PST)
In-Reply-To: <4EC6C76F.40700@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

[Resending, previous was blocked by the list as html.. oops]

On Fri, Nov 18, 2011 at 13:00, Wido den Hollander <wido@widodh.nl> wrot=
e:
>
> Is there any way I can contribute to the docs in ceph.newdream.net/do=
cs? Since the docs are moving it might be a better place to write some =
docs there?

You have push access to phprados.git now.

The docs are just reStructuredText files in doc/ =C2=A0subdirectory of
ceph.git, built with ./admin/build-doc using=C2=A0http://sphinx.pocoo.o=
rg/
-- submit patches and pull requests as you would normally.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
