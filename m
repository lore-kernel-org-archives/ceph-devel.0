From: Sage Weil <sage@inktank.com>
Subject: Re: reproducable osd crash
Date: Wed, 27 Jun 2012 08:19:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206270818440.18530@cobra.newdream.net>
References: <4FE319DF.3020106@profihost.ag> <B37E1F82-25E3-4ED4-B3E9-59BC2EC44CB6@profihost.ag>
 <4FE4F806.1080501@inktank.com> <CA+4uBUb9WVk7-htq_qBNF-T_8i4-3KEsJePhTYoAHXuXfyOuKA@mail.gmail.com>
 <7855C271-3A73-4090-9F5F-2F4FB12C4E73@profihost.ag>
 <B8C4CA17-911D-4BA4-BE1D-4E81168A4212@inktank.com> <4FE89DB0.1080606@profihost.ag>
 <4FE8D1BF.3090108@inktank.com> <4FE8D5B5.8050902@profihost.ag>
 <4FE8FE36.6080001@inktank.com> <7F6C4684-EE9F-419D-B812-DFF1C498C36B@profihost.ag>
 <0F9BBB6D-F537-4C17-8E05-91931D89199D@profihost.ag>
 <CADvuQRGS4xCyxbYVPNNPVyc4dZQVgnDXbHcTkKf0ZbscPCjewA@mail.gmail.com>
 <4FE9E796.4050000@profihost.ag> <CA+4uBUaf28Ug34kh2uEbfHeEE13X-YgVmpUsyKDgqrCbUUPWGA@mail.gmail.com>
 <4FEAB4A7.2060906@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50629 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757522Ab2F0PTP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Jun 2012 11:19:15 -0400
In-Reply-To: <4FEAB4A7.2060906@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Sam Just <sam.just@inktank.com>, Tommi Virtanen <tv@inktank.com>, Dan Mick <dan.mick@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 27 Jun 2012, Stefan Priebe - Profihost AG wrote:
> THANKS a lot. This fixes it. I've merged your branch into next and i wsn't
> able to trigger the osd crash again. So please include this into 0.48.

Excellent.  Thanks for testing!  This now in next.

sage


> 
> Greets
> Stefan
> 
> Am 26.06.2012 20:01, schrieb Sam Just:
> > Stefan,
> > 
> > Sorry for the delay, I think I've found the problem.  Could you give
> > wip_ms_handle_reset_race a try?
> > -Sam
> > 
> > On Tue, Jun 26, 2012 at 9:47 AM, Stefan Priebe <s.priebe@profihost.ag>
> > wrote:
> > > Am 26.06.2012 18:05, schrieb Tommi Virtanen:
> > > 
> > > > On Mon, Jun 25, 2012 at 10:48 PM, Stefan Priebe <s.priebe@profihost.ag>
> > > > wrote:
> > > > > 
> > > > > Strange just copied /core.hostname and /usr/bin/ceph-osd no idea how
> > > > > this
> > > > > can happen. For building I use the provided Debian scripts.
> > > > 
> > > > 
> > > > Perhaps you upgraded the debs but did not restart the daemons? That
> > > > would make the on-disk executable with that name not match the
> > > > in-memory one.
> > > 
> > > 
> > > No, i reboot after each upgrade ;-)
> > > 
> > > Right now i'm witing for a FS fix xfs or btrfs and i will then reproduce
> > > the
> > > issue.
> > > 
> > > Stefan
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
