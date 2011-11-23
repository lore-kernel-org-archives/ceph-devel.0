From: Laszlo Boszormenyi <gcs@debian.hu>
Subject: Re: [PATCH] debian init: Do not stop or start daemons when
 installing or upgrading
Date: Wed, 23 Nov 2011 22:22:54 +0100
Message-ID: <1322083374.18718.29.camel@julia.gcs.org.hu>
References: <1321472475-19115-1-git-send-email-wido@widodh.nl>
	 <1321472475-19115-2-git-send-email-wido@widodh.nl>
	 <Pine.LNX.4.64.1111161152550.22555@cobra.newdream.net>
	 <4ECD509C.4020108@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.barcikacomp.hu ([94.248.160.10]:40206 "EHLO
	mail.barcikacomp.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755882Ab1KWVdG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Nov 2011 16:33:06 -0500
In-Reply-To: <4ECD509C.4020108@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

On Wed, 2011-11-23 at 20:59 +0100, Wido den Hollander wrote:
> On 11/16/2011 08:53 PM, Sage Weil wrote:
> > Ooh, that would certainly make things less annoying for me as well.
> > Unless that's contrary to some debian policy/best practice, Laszlo?
 Will check Debian policy. I think init scripts in other packages use a
variable in /etc/default/<package> like no_restart_on_upgrade .
On the other hand, I think init script may check if ceph is running or
not. If not, it should not start it. Leaving it running while ceph is
upgraded would be a bad idea. You would miss configuration file changes
and realize that it broke your node at random times when ceph is
restarted for any reason.

> Laszlo, have you been able to look at this yet?
 Ouch, haven't seen this thread yet. Hope that I can answer in detail
soon.

Laszlo/GCS

