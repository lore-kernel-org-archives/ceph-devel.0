From: Matt Weil <mweil@genome.wustl.edu>
Subject: bad fsid
Date: Mon, 05 Mar 2012 12:43:02 -0600
Message-ID: <4F550936.8020701@genome.wustl.edu>
References: <4F516A75.6020500@cs.ucsc.edu> <CAORUGqCgPzhSKzOdxHsQG=o64zrhzUmLvDOd5u3Q5k-+0_Q8YQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from gscsmtp.wustl.edu ([128.252.233.26]:45503 "HELO
	gscsmtp.wustl.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755577Ab2CESnE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Mar 2012 13:43:04 -0500
Received: from dhcp-10-0-108-185.gsc.wustl.edu (dhcp-10-0-108-185.gsc.wustl.edu [10.0.108.185])
	by gscsmtp.wustl.edu (Postfix) with ESMTPSA id 08CA740C13
	for <ceph-devel@vger.kernel.org>; Mon,  5 Mar 2012 12:43:03 -0600 (CST)
In-Reply-To: <CAORUGqCgPzhSKzOdxHsQG=o64zrhzUmLvDOd5u3Q5k-+0_Q8YQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I recreated the file system and got this on the client until it was 
rebooted.

Is there a step I missed?

> libceph: bad fsid, had 02f7ef57-25e0-475f-8948-5c562a4d370c got 6089a28f-8ff4-42f5-8825-1a929f5770bd

