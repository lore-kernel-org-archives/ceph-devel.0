From: Kyle Bader <kyle@inktank.com>
Subject: Re: durability model
Date: Mon, 26 May 2014 23:50:33 -0700
Message-ID: <CAHxYaFN6R3F6Tn0Vnh9N+pAXhOT8F7+gYLTzTgonn==GJUpX_w@mail.gmail.com>
References: <1401131148.7008.YahooMailNeo@web165003.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:59739 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884AbaE0Guf convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 May 2014 02:50:35 -0400
Received: by mail-lb0-f179.google.com with SMTP id c11so4587326lbj.24
        for <ceph-devel@vger.kernel.org>; Mon, 26 May 2014 23:50:33 -0700 (PDT)
In-Reply-To: <1401131148.7008.YahooMailNeo@web165003.mail.bf1.yahoo.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Koleos Fuskus <koleosfuscus@yahoo.com>
Cc: "loic@dachary.org" <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

> Something that is not yet clear for me is how do we study the overlapping of different layers of reliability using the modelling tool. Is the idea to use erasure coding on top of another reliable layer like a RAID-based storage? If I understand correctly the current tool models disks, RAID, RADOS independently. But erasure coding is added on top of those layers, isn't it?

You understand correctly in that the tool was originally written to
analyze RADOS with replication and RAID, independently. Erasure coding
can be used independently and I had considered the original scope to
be modeling just that, a erasure coded pool in isolation. Being able
to model durability of a tiered pool configuration would be an
excellent next step, though. Good question!

-- 
Kyle Bader - Inktank
Senior Solution Architect
