From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: Ceph watchdog-like thing to reduce IO block during process goes
 down by abort()
Date: Fri, 25 Mar 2016 11:35:40 -0400 (EDT)
Message-ID: <1678946020.74929829.1458920140445.JavaMail.zimbra@redhat.com>
References: <27d3bfba39234f83b8441abc4e9aea92@R01UKEXCASM222.r01.fujitsu.local> <CAOi1vP89OgUmvozXRO9cvNS-KYaSkBGQRkPS3UeNa2+kgAHkmA@mail.gmail.com> <CAJ4mKGbDQEyRfeMskBwsTxK_qoJY_4GfGfFz1h1ht6h6E0xhSg@mail.gmail.com> <CANP1eJFto2wEGaWt_dgys-cMQn_6t3wFrWwcURwkX0Y+HY_PKQ@mail.gmail.com> <alpine.DEB.2.11.1603251109400.26068@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:60874 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752026AbcCYPfs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Mar 2016 11:35:48 -0400
In-Reply-To: <alpine.DEB.2.11.1603251109400.26068@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Milosz Tanski <milosz@adfin.com>, Gregory Farnum <gfarnum@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Igor Podoski <Igor.Podoski@ts.fujitsu.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi,

----- Original Message -----
> From: "Sage Weil" <sweil@redhat.com>
> To: "Milosz Tanski" <milosz@adfin.com>
> Cc: "Gregory Farnum" <gfarnum@redhat.com>, "Ilya Dryomov" <idryomov@gmail.com>, "Igor Podoski"
> <Igor.Podoski@ts.fujitsu.com>, "ceph-devel" <ceph-devel@vger.kernel.org>
> Sent: Friday, March 25, 2016 11:12:34 AM
> Subject: Re: Ceph watchdog-like thing to reduce IO block during process goes down by abort()

> > There's no reason the watcher process can't be a child that's kicked
> > off when the OSD startups. If there's a pipe between the two, when the
> > parent goes away the child will get a EOF on reading from the pipe. On
> > Linux you can also do a cute trick to have the child notified when
> > parent quits using prctl(PR_SET_PDEATHSIG, SIG???).
> 
> That does simplify the startup/management piece, but it means one watcher
> per OSD, and since we want the watcher to have an active mon session to
> make the notification quick, it doubles the mon session load.

Not sure if it's helpful, but

a) the count of sessions drops back once logical OSDs are colocated?
b) AFS had the notion of the "basic overseer" that started all its other processes--so you I think had the pipe infrastructure set up to do this sort of thing more like in Milosz' model, but just the one overseer per host

(But I might be misreading the thread.)

> 
> Honestly I don't think the separate daemon is that much of an issue--it's
> a systemd unit file and a pretty simple watchdog process.  The key
> management and systemd enable/activate bit is the part that will be
> annoying.
> 
> sage
> --

Matt

-- 
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-707-0660
fax.  734-769-8938
cel.  734-216-5309
