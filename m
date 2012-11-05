From: Wido den Hollander <wido@widodh.nl>
Subject: Re: RADOS extensions directory
Date: Mon, 05 Nov 2012 12:23:34 +0100
Message-ID: <5097A1B6.2040006@widodh.nl>
References: <5097872C.8030803@unilogicnetworks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:57157 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611Ab2KELXh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Nov 2012 06:23:37 -0500
In-Reply-To: <5097872C.8030803@unilogicnetworks.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Pascal de Bruijn <pascal@unilogicnetworks.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



On 05-11-12 10:30, Pascal de Bruijn wrote:
> Hi,
>
> In light of #cephday I noticed something that struck me as odd. The
> presenation listed the following as the RADOS extensions directory (if I
> recall correctly):
>
> /var/lib/rados/*.so

/var/lib/rados-classes/*.so

It's handled by this configuration option:

OPTION(osd_class_dir, OPT_STR, CEPH_LIBDIR "/rados-classes")

I think however that Sage's slide was wrong, my configuration is:

-DCEPH_LIBDIR="/usr/lib"

On my system I also have /usr/lib/rados-classes/*.so

It might have been a old build issue, since I also recall it being in 
/var/lib

>
> However, it's very atypical to have shared libraries in /var. As far as
> I know /var/lib is typically used for persistent (non-executable)
> storage (think dpkg for example).
>
> So I'm guessing /usr/lib/rados/*.so would probably be a more suitable
> home for the RADOS extensions.
>
> While this isn't the most important thing in the world, I guess it makes
> sense to change this now as it's not a commonly used feature yet (read
> there are no third party packages depending on this location yet).
>
> In addition when submitting the code for inclusion into Debian/Fedora, I
> wouldn't be surprised if they had similar "objections".
>

Looking at debian/ceph.install it also packages /usr/lib/rados-classes.

> At #cephday I briefly spoke to Wido about this, if I recall correctly he
> confirmed this was sortof a known issue. If that's correct please view
> this e-mail just as a reminder or something.
>

Seems resolved already, although I'm not sure if I would do 
"rados-classes"? Maybe /usr/lib/rados/classes/* ?

Wido

> Regards,
> Pascal de Bruijn
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
