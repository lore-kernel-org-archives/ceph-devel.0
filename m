From: John Nielsen <lists@jnielsen.net>
Subject: Re: Understanding Ceph
Date: Wed, 23 Jan 2013 17:17:03 -0700
Message-ID: <96316186-B7ED-46F9-A01D-C88165C40530@jnielsen.net>
References: <CAPrNTukzeSN8ZfO_Mhtx9LkHqe0M3tUxJuQG=gwwJD4w+-OGEg@mail.gmail.com> <50FAC92C.8030709@bmrb.wisc.edu> <alpine.DEB.2.00.1301190911470.29915@cobra.newdream.net> <CAPrNTukzfE0KNMG+Rww8FBOCFq_BZr29Kb0zQRCf0K40oX4enQ@mail.gmail.com> <alpine.DEB.2.00.1301190933000.29915@cobra.newdream.net> <50FAE116.2010504@gmail.com> <alpine.DEB.2.00.1301191012400.29915@cobra.newdream.net> <50FC1DCF.8010304@bmrb.wisc.edu> <CAKMAVE-4g_0Jab6sQ3S49oMadENEzetCLOB0sAo_o39d+RnDaQ@mail.gmail.com> <CAP8Oy=Kwbs0AV9Tb3un79FuFB=R4M78wgb2g3+Fb=K70nXfEnA@mail.gmail.com> <51007C0C.2030107@bmrb.wisc.edu>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from secure.freebsdsolutions.net ([69.55.234.48]:55130 "EHLO
	ns1.jnielsen.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752111Ab3AXARE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Jan 2013 19:17:04 -0500
In-Reply-To: <51007C0C.2030107@bmrb.wisc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dimitri Maziuk <dmaziuk@bmrb.wisc.edu>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Jan 23, 2013, at 5:10 PM, Dimitri Maziuk <dmaziuk@bmrb.wisc.edu> wrote:

> On 01/23/2013 10:19 AM, Patrick McGarry wrote:
> 
>> http://ceph.com/howto/building-a-public-ami-with-ceph-and-openstack/
> 
>> On Wed, Jan 23, 2013 at 10:13 AM, Sam Lang <sam.lang@inktank.com> wrote:
> 
>>> http://ceph.com/docs/master/rbd/rbd-openstack/
> 
> These are both great, I'm sure, but Patrick's page says "I chose to
> follow the 5 minute quickstart guide" and the rbd-openstack page says
> "Important ... you must have a running Ceph cluster."
> 
> My problem is I can;t find a "5 minute quickstart guide" for RHEL 6. and
> I didn't get a "running ceph cluster" by trying to follow the existing
> (ubuntu) guide and adjust for centos 6.3.

http://ceph.com/docs/master/install/rpm/
http://ceph.com/docs/master/start/quick-start/

Between those two links my own quick-start on CentOS 6.3 was maybe 6 minutes. YMMV.

After learning that qemu uses librbd (and thus doesn't rely on the rbd kernel module) I was happy to stick with the stock CentOS kernel for my servers (with updated qemu and libvirt builds).

> So I'm stuck at a point way before those guides become relevant: once I
> had one OSD/MDS/MON box up, I got "HEALTH_WARN 384 pgs degraded; 384 pgs
> stuck unclean; recovery 21/42 degraded (50.000%)" (384 appears be the
> number of placement groups created by default).
> 
> What does that mean? That I only have one OSD? Or is it genuinely unhealthy?

Assuming you have more than one host, be sure that iptables or another firewall isn't preventing communication between the ceph daemons.

JN

