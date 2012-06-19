From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: Heavy speed difference between rbd and custom pool
Date: Tue, 19 Jun 2012 08:32:07 +0200
Message-ID: <4FE01CE7.8000204@profihost.ag>
References: <bfd5bdd7-1959-445f-8016-7b98ae5eb6e9@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:59628 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314Ab2FSGcL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Jun 2012 02:32:11 -0400
In-Reply-To: <bfd5bdd7-1959-445f-8016-7b98ae5eb6e9@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: ceph-devel@vger.kernel.org

Am 19.06.2012 06:41, schrieb Alexandre DERUMIER:
> Hi Stephann
> recommandations are 30-50 PGS by osd if I remember.
>
rbd, data and metadata have 2176 PGs with 12 OSD. This is 181,333333333 
per OSD?!

Stefan
