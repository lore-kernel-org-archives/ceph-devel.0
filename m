From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: Geo-replication with RADOS GW
Date: Wed, 30 Jan 2013 17:53:15 +0100
Message-ID: <CAJH6TXj15-OKmf6Wpwgtsn_SfC7RTO9s+iG3uCNra-9LFPg-aA@mail.gmail.com>
References: <CAEU8emnv5z9JmkqTG4+ddNV6wRLQfeSQyPShznyg=xFzqTYwpg@mail.gmail.com>
	<4A295B7B36B341578D4F02AC963BB353@inktank.com>
	<2FECDD68-4116-47BC-A709-8C0BB2585049@jnielsen.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:58692 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753737Ab3A3QxR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Jan 2013 11:53:17 -0500
Received: by mail-wi0-f180.google.com with SMTP id hj13so1874848wib.13
        for <ceph-devel@vger.kernel.org>; Wed, 30 Jan 2013 08:53:15 -0800 (PST)
In-Reply-To: <2FECDD68-4116-47BC-A709-8C0BB2585049@jnielsen.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Nielsen <lists@jnielsen.net>
Cc: Ben Rowland <ben.rowland@gmail.com>, ceph-devel@vger.kernel.org

2013/1/30 John Nielsen <lists@jnielsen.net>:
> I don't know what the timeline is, but Yehuda proposed recently the idea of master and slave "zones" (subsets of a cluster) and other changes to facilitate "rgw geo-replication and disaster recovery". See this message:
>         http://article.gmane.org/gmane.comp.file-systems.ceph.devel/12238

What about "split queries" like mysql-proxy can do with mysql or like
mysql replication?

Due different ceph cluster in two different location and a radosgw
loadbalancer in front of both that will replicate PUT/DELETE on both
clusters
