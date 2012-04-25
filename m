From: Christian Brunner <christian@brunner-muc.de>
Subject: Re: Ceph on btrfs 3.4rc
Date: Wed, 25 Apr 2012 13:28:14 +0200
Message-ID: <CAJafhzQ0BtNsUSr4cPYLg1MfMoKQhvYE3eS6VskRBeyJOF58iw@mail.gmail.com>
References: <CAJafhzSVZ3+1ApgJU=sQu6gM62BeWVGG4mqFPNYRHx79czYJtQ@mail.gmail.com>
	<20120424152141.GB3326@localhost.localdomain>
	<Pine.LNX.4.64.1204240922040.29159@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39136 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758591Ab2DYL2O convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Apr 2012 07:28:14 -0400
Received: by iadi9 with SMTP id i9so2372035iad.19
        for <ceph-devel@vger.kernel.org>; Wed, 25 Apr 2012 04:28:14 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1204240922040.29159@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Josef Bacik <josef@redhat.com>, ceph-devel@vger.kernel.org

Am 24. April 2012 18:26 schrieb Sage Weil <sage@newdream.net>:
> On Tue, 24 Apr 2012, Josef Bacik wrote:
>> On Fri, Apr 20, 2012 at 05:09:34PM +0200, Christian Brunner wrote:
>> > After running ceph on XFS for some time, I decided to try btrfs ag=
ain.
>> > Performance with the current "for-linux-min" branch and big metada=
ta
>> > is much better. The only problem (?) I'm still seeing is a warning
>> > that seems to occur from time to time:
>
> Actually, before you do that... we have a new tool,
> test_filestore_workloadgen, that generates a ceph-osd-like workload o=
n the
> local file system. =A0It's a subset of what a full OSD might do, but =
if
> we're lucky it will be sufficient to reproduce this issue. =A0Somethi=
ng like
>
> =A0test_filestore_workloadgen --osd-data /foo --osd-journal /bar
>
> will hopefully do the trick.
>
> Christian, maybe you can see if that is able to trigger this warning?
> You'll need to pull it from the current master branch; it wasn't in t=
he
> last release.

I've tried test_filestore_workloadgen, but it didn't work very well.
After 5 Minutes it terminated with the following messages:

2012-04-25 11:28:57.768709 7fcac3f69760  0 Destroying collection
'0.1_head' (358 objects)
2012-04-25 11:29:07.478747 7fcac3f69760  0 Destroying collection
'0.22_head' (477 objects)
2012-04-25 11:29:07.479035 7fcac3f69760  0 We ran out of collections!
2012-04-25 11:29:07.916149 7fcac3f69760  1 journal close
/dev/mapper/vg01-lv_osd_journal_0

I guess this is not btrfs related .-)

@Josef: If Sage doesn't have any other solution, I'll put up some ceph
installation instructions.

Regards,
Christian
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
