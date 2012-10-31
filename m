From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: Ceph journal
Date: Wed, 31 Oct 2012 23:07:26 +0100
Message-ID: <CAJH6TXgn4JDJ_gLJGzoeFkMaU5qgREW8EEqWj5yh2AtPQjzrhg@mail.gmail.com>
References: <CAJH6TXgdkq8ZMUpZYaTActMQ9wS76u7F=OUSvWnt9bS-crJwZQ@mail.gmail.com>
	<CANLRBoyLHrLP_hg6DSbESk=JhfHa5rzHiyLHcAotUokRe--xVA@mail.gmail.com>
	<CAJH6TXjGP5QqOWchRTwUQ-EigCU9qAORA87JrZ6bhG5J4im=-A@mail.gmail.com>
	<5091A06E.20407@kleijkers.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:37919 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758583Ab2JaWH2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 31 Oct 2012 18:07:28 -0400
Received: by mail-ea0-f174.google.com with SMTP id c13so749262eaa.19
        for <ceph-devel@vger.kernel.org>; Wed, 31 Oct 2012 15:07:26 -0700 (PDT)
In-Reply-To: <5091A06E.20407@kleijkers.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Kleijkers <stefan@kleijkers.nl>
Cc: Tren Blackburn <tren@eotnetworks.com>, ceph-devel@vger.kernel.org

2012/10/31 Stefan Kleijkers <stefan@kleijkers.nl>:
> As far as I know, this is correct. You get a ACK (on the write) back after
> it landed on ALL three journals (or/and osds in case of BTRFS in parallel
> mode). So If you lose one node, you still have it in two more nodes and they
> will commit it to disk. After recovering the missing node/osd it will get
> the data from one of the other nodes. So you won't lose any data.

Sounds perfect, this will allow me to avoid SSD disks and using al 12
disks on a DELL R515 as OSD
