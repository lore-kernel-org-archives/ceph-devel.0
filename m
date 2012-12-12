From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: ceph osd create XX
Date: Wed, 12 Dec 2012 22:38:01 +0100
Message-ID: <50C8F939.6080400@profihost.ag>
References: <50C8F7AC.9070600@profihost.ag> <CAPYLRzjntgh+CHXbtoRvLHhvjo1wqT9F16vshsiBhLcYebUB-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:55116 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755059Ab2LLViB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Dec 2012 16:38:01 -0500
In-Reply-To: <CAPYLRzjntgh+CHXbtoRvLHhvjo1wqT9F16vshsiBhLcYebUB-Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

HI Greg,

sorry just a copy & paste error.

[cloud1-ceph1: ~]# ceph osd create 61
(22) Invalid argument

> Read those two lines again. Very slowly. :)
>
> The correct syntax is
> ceph osd create <uuid>
>
> The uuid is optional, but you don't specify IDs; it gives you an ID back.

Stefan
