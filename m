From: Gregory Farnum <greg@inktank.com>
Subject: Re: Best practice with 0.48.2 to take a node into maintenance
Date: Mon, 3 Dec 2012 12:22:06 -0800
Message-ID: <CAPYLRzgiEMssG1gKj-jm6_CmZBjH1FPx7fuY-iVXu=LxbQ2RGw@mail.gmail.com>
References: <0F892E7E-CF04-49A2-9ABA-5EAF25E6D645@filoo.de>
	<50BCFA2F.9070603@inktank.com>
	<EB4A37AF-6A19-4F66-B5E3-AED15BECED06@filoo.de>
	<50BD014E.90304@smart-weblications.de>
	<7B185153-8ABF-4FB4-890A-4D5E8C789C55@filoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:62085 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752007Ab2LCUWJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Dec 2012 15:22:09 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so2495582iay.19
        for <ceph-devel@vger.kernel.org>; Mon, 03 Dec 2012 12:22:08 -0800 (PST)
In-Reply-To: <7B185153-8ABF-4FB4-890A-4D5E8C789C55@filoo.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Oliver Francke <Oliver.Francke@filoo.de>
Cc: Florian Wiessner <f.wiessner@smart-weblications.de>, ceph-devel <ceph-devel@vger.kernel.org>, Josh Durgin <josh.durgin@inktank.com>

On Mon, Dec 3, 2012 at 12:13 PM, Oliver Francke <Oliver.Francke@filoo.d=
e> wrote:
> if you encounter all BIOS-, POST-, RAID-controller-checks, linux-boot=
, openvswitch-STP setup and so on, one can imagine, that a reboot takes=
 a "couple-of-minutes", normally with our setup after 30 seconds the cl=
uster shall detect some outage and start to do it's work.
> Everytings fine, but perhaps we could avoid big load in the cluster t=
o remap and re-remap ( "Theme: slow requests") I have to ask in means o=
f QoS for a "better way" ;)
> All that stuff had a big customer impact in the past=85 Time to ask.

If you know you're going to be doing maintenance that might take a
while, and are going to be closely monitoring your cluster for issues,
it might be appropriate to do:
ceph osd set noout

Which will prevent any OSDs from being marked "out", and thus prevent
any migrations or backfills. You can turn it off again with
ceph osd unset noout

Of course, since this means Ceph won't do any re-replication, so
you'll need to step up your manual monitoring to compensate!
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
