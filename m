From: Laszlo Boszormenyi <gcs@debian.hu>
Subject: Re: packaging for ceph-gui
Date: Tue, 21 Dec 2010 15:44:09 +0100
Message-ID: <1292942649.25876.36.camel@julia.gcs.org.hu>
References: <Pine.LNX.4.64.1012141155100.26702@cobra.newdream.net>
	 <1292358476.25794.88.camel@julia.gcs.org.hu>
	 <Pine.LNX.4.64.1012141235310.22978@cobra.newdream.net>
	 <1292359839.25794.99.camel@julia.gcs.org.hu>
	 <AANLkTikmi_Ke02Fd4BrRXGCiKHSuQhCwY6UME+QU04Uh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.routers.hu ([212.40.96.82]:36602 "EHLO mail.routers.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751928Ab0LUOpC (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 21 Dec 2010 09:45:02 -0500
In-Reply-To: <AANLkTikmi_Ke02Fd4BrRXGCiKHSuQhCwY6UME+QU04Uh@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

Hi Colin,

On Tue, 2010-12-14 at 13:06 -0800, Colin McCabe wrote:
> Yeah, after some discussion, I think we're sticking with gceph. Sorry
> for the email spam :)
 Don't worry, I'm always open for discussions. Only please don't make me
believe I changed your mind about any change in ceph development or I'll
apply for a job there and ask for some money in return. :)

> Let me know if you have any issues w/ packaging...
 I've a question. gceph needs everything noted in debian/ceph.install
(cephfs, cconf, ... the rados classes and manpages), right? The best
would be to make a ceph-common package, depending on ceph | gceph and
the latter packages would contain only the binaries ceph and gceph
respectively. Am I right?

Laszlo/GCS

