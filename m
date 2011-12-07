From: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Subject: Re: Cannot mount ceph filesystem: error 5 (Input/Output error)
Date: Wed, 07 Dec 2011 15:38:57 +0100
Message-ID: <1871670.5qvOuPR13S@pc10>
References: <4366451.BU1d1YAr76@pc10> <3826746.5bRf3lS2YZ@tolkien> <CAF3hT9DSf5Xaw00PUFHp5OtGAabka+Wc6H4vVkK24PJGNizd4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from unknownsite.de ([62.48.69.106]:55815 "EHLO hartes-hannover.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755798Ab1LGOi7 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 7 Dec 2011 09:38:59 -0500
Received: from pc10.localnet (pc10.asys-h.de [193.98.1.90])
	by hartes-hannover.de (Postfix) with ESMTPSA id 8C4CF10C866
	for <ceph-devel@vger.kernel.org>; Wed,  7 Dec 2011 15:38:58 +0100 (CET)
In-Reply-To: <CAF3hT9DSf5Xaw00PUFHp5OtGAabka+Wc6H4vVkK24PJGNizd4Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Am Dienstag, 6. Dezember 2011, 11:51:45 schrieben Sie:
> PG = "placement group". When placing data in the cluster, objects are
> mapped into PGs, and those PGs are mapped onto OSDs.

How does the Object->PG mapping look like, do you map more than one object on 
one PG, or do you sometimes map an object to more than one PG? How about the 
mapping of PGs to OSDs, does one PG belong to exactly one OSD?

Does one PG represent a fixed amount of storage space?

        Guido
