From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: stable 10GBE under 3.4.2 or 3.5.0-rc2
Date: Mon, 18 Jun 2012 11:25:10 +0200
Message-ID: <4FDEF3F6.8090509@profihost.ag>
References: <1656f33e-a77c-42aa-ac97-e351f90db724@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:56186 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954Ab2FRJZM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jun 2012 05:25:12 -0400
In-Reply-To: <1656f33e-a77c-42aa-ac97-e351f90db724@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: ceph-devel@vger.kernel.org

Am 18.06.2012 11:21, schrieb Alexandre DERUMIER:
> Did you use same driver version with the differents kernel version ?

Yes driver: ixgbe version: 3.9.17-NAPI.

> Maybe try to  desactive tso,gso,... with ethtool ?

Already tried that no change and remember it works fine with 3.0.32.

Stefan
