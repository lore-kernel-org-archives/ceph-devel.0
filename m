From: Paul Sherriffs <PSherriffs@humancircuit.com>
Subject: Using a Data Pool
Date: Wed, 23 Jan 2013 13:01:19 +0000
Message-ID: <480DDC4F67FD9A438EE28BFEB1299FA98981C0A3@EX3.HQDOMAIN.LOCAL>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 173-13-192-33-WashingtonDC.hfc.comcastbusiness.net ([173.13.192.33]:54938
	"EHLO barracuda.ppionline.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750852Ab3AWNMU convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 23 Jan 2013 08:12:20 -0500
Received: from EX3.HQDOMAIN.LOCAL (ex3.hqdomain.local [10.1.1.24]) by barracuda.ppionline.com with ESMTP id 2rGMn6uIJexCFNmE for <ceph-devel@vger.kernel.org>; Wed, 23 Jan 2013 08:01:21 -0500 (EST)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello All;

I have been trying to associate a directory to a data pool (both called 'Media') according to a previous thread on this list. It all works except the last line:


ceph osd pool create Media 500 500

ceph mds add_data_pool 3

>added data pool 3 to mdsmap

mkdir /mnt/ceph/Media

cephfs /mnt/ceph/Media set_layout -p 3

>Segmentation fault


What am I doing wrong? I'm running 0.56.1 on Ubantu 12.10 Kernel 3.7.1

Thanks
-Paul
