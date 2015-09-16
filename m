From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Very slow recovery/peering with latest master
Date: Wed, 16 Sep 2015 11:35:06 -0700
Message-ID: <CAJ4mKGa1vr6Zp9ZUaT8rrHDgRFJgdkO2c8LZqMQuwxwYt7TJ+A@mail.gmail.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE48251@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:37968 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752633AbbIPSfI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Sep 2015 14:35:08 -0400
Received: by wiclk2 with SMTP id lk2so83252872wic.1
        for <ceph-devel@vger.kernel.org>; Wed, 16 Sep 2015 11:35:07 -0700 (PDT)
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE48251@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Sep 15, 2015 at 8:04 PM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> Hi,
> I am seeing very slow recovery when I am adding OSDs with the latest master.
> Also, If I just restart all the OSDs (no IO is going on in the cluster) , cluster is taking a significant amount of time to reach in active+clean state (and even detecting all the up OSDs).
>
> I saw the recovery/backfill default parameters are now changed (to lower value) , this probably explains the recovery scenario , but, will it affect the peering time during OSD startup as well ?

I don't think these values should impact peering time, but you could
configure them back to the old defaults and see if it changes.
-Greg
