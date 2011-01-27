From: Wido den Hollander <wido@widodh.nl>
Subject: Re: btrfs BUG during Ceph cosd truncate() syscall
Date: Thu, 27 Jan 2011 17:36:42 +0100
Message-ID: <1296146202.2186.25.camel@wido-laptop.pcextreme.nl>
References: <1296057606.23762.56.camel@sale659.sandia.gov>
	 <1296064793.23762.70.camel@sale659.sandia.gov>
	 <1296067685.23762.74.camel@sale659.sandia.gov>
	 <1296144315.23762.91.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:51042 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223Ab1A0Qgp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Jan 2011 11:36:45 -0500
In-Reply-To: <1296144315.23762.91.camel@sale659.sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Jim,

On Thu, 2011-01-27 at 09:05 -0700, Jim Schutt wrote:
> Hi,
> 
> I got this kernel BUG on a server running multiple Ceph
> cosd instances.  I'm not sure what was going on at the
> time, as I just noticed this on my serial console for
> this node.
> 
> It looks like another example of the truncate issue in
> Matt Weil's report.

Yes, I saw the same. I've been mailing with Josef Bacik and he asked me
to try his latest btrfs with some patches: 

git://git.kernel.org/pub/scm/linux/kernel/git/josef/btrfs-work.git

Could you try that (master branch) (Compiles against 2.6.38 btw)

I've been running it now for a few hours and seems to be stable, where
it would fail within 30 minutes yesterday.

Wido

