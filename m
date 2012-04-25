From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re-replicated data does not seem to get uniformly redistributed
 after OSD failure
Date: Wed, 25 Apr 2012 16:40:00 -0600
Message-ID: <4F987D40.8040101@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:41010 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932274Ab2DYWkX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Apr 2012 18:40:23 -0400
Received: from interceptor2.sandia.gov (interceptor2.sandia.gov [132.175.109.18])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sentry-two.sandia.gov (Postfix) with ESMTP id 1252A1EB852
	for <ceph-devel@vger.kernel.org>; Wed, 25 Apr 2012 16:40:21 -0600 (MDT)
Received: from sentry.sandia.gov (mm03snlnto.sandia.gov [132.175.109.20]) by interceptor2.sandia.gov (RSA Interceptor) for <ceph-devel@vger.kernel.org>; Wed, 25 Apr 2012 16:40:04 -0600
Received: from mail.sandia.gov (exch04.sandia.gov [134.253.103.4] (may
 be forged)) by mailgate2.sandia.gov (8.14.4/8.14.4) with ESMTP id
 q3PMe1O7016798 for <ceph-devel@vger.kernel.org>; Wed, 25 Apr 2012
 16:40:01 -0600
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

I've been experimenting with failure scenarios to make sure
I understand what happens when an OSD drops out.  In particular,
I've been using "ceph osd out <n>" and watching my all my OSD
servers to see where the data from the removed OSD ends up
after recovery.  I've been doing this testing with 12 servers,
24 OSDs/server.

What I see is that all the data from the removed OSD seem to
end up distributed across the other OSDs on the host holding
the removed OSD.

It works this way if I use the default CRUSH map generated
for just host buckets and devices, i.e. a map using the
straw algorithm for the root and host buckets.  It also
works this way if I generate my own map using the uniform
algorithm for the root and host buckets.

For example, using my map based on the uniform algorithm,
after successively taking out osd.0 thru osd.9 (all on
host cs32), here's the top 24 OSD data store usage:

Host           1K-blocks      Used Available Use% Mounted on

cs39:          942180120  33379144 871114904   4% /ram/mnt/ceph/data.osd.174
cs39:          942180120  33386420 871106604   4% /ram/mnt/ceph/data.osd.186
cs43:          942180120  33484704 871008448   4% /ram/mnt/ceph/data.osd.270
cs43:          942180120  33563912 870930616   4% /ram/mnt/ceph/data.osd.267
cs38:          942180120  33637652 870856876   4% /ram/mnt/ceph/data.osd.162
cs34:          942180120  33773780 870721740   4% /ram/mnt/ceph/data.osd.67
cs37:          942180120  33834584 870660136   4% /ram/mnt/ceph/data.osd.123
cs40:          942180120  33936696 870557928   4% /ram/mnt/ceph/data.osd.203
cs38:          942180120  34212020 870283404   4% /ram/mnt/ceph/data.osd.165
cs42:          942180120  34402852 870095036   4% /ram/mnt/ceph/data.osd.259
cs32:          942180120  45969104 858567088   6% /ram/mnt/ceph/data.osd.17
cs32:          942180120  49694156 854854196   6% /ram/mnt/ceph/data.osd.16
cs32:          942180120  50182636 854370356   6% /ram/mnt/ceph/data.osd.15
cs32:          942180120  50520484 854030460   6% /ram/mnt/ceph/data.osd.12
cs32:          942180120  50669280 853882848   6% /ram/mnt/ceph/data.osd.10
cs32:          942180120  51234372 853319452   6% /ram/mnt/ceph/data.osd.14
cs32:          942180120  51277080 853276808   6% /ram/mnt/ceph/data.osd.22
cs32:          942180120  51279984 853273392   6% /ram/mnt/ceph/data.osd.13
cs32:          942180120  52364512 852192000   6% /ram/mnt/ceph/data.osd.23
cs32:          942180120  52376512 852180384   6% /ram/mnt/ceph/data.osd.21
cs32:          942180120  53026724 851531228   6% /ram/mnt/ceph/data.osd.18
cs32:          942180120  53217832 851343128   6% /ram/mnt/ceph/data.osd.20
cs32:          942180120  53723152 850838768   6% /ram/mnt/ceph/data.osd.19
cs32:          942180120  56159652 848410460   7% /ram/mnt/ceph/data.osd.11

I was thinking that CRUSH would re-replicate considering all
buckets, subject to preventing multiple replicas in the same
bucket, based on this from Sage's thesis, section 5.2.2.1:

    For failed or overloaded devices, CRUSH uniformly
    redistributes items across the storage cluster by
    restarting the recursion at the beginning of the
    select(n,t) (see Algorithm 1 line 11).

So my question is, what am I missing?  Maybe the above doesn't
mean what I think it does?  Or, is there some configuration
that I should be using but don't know about?

Thanks -- Jim


