From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: Rack Awareness
Date: Tue, 15 Jan 2013 11:34:42 +0100
Message-ID: <CAJH6TXj96-OSbR+8MrS7o4bjzcC-zj=2z88sE=6TWzvadHNTTg@mail.gmail.com>
References: <CAJH6TXiCxyqb877HiCpj7uLpiBUPjAL5sPxrMnd1n1fXub85pg@mail.gmail.com>
	<50F52E4C.4000704@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:53742 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756066Ab3AOKlE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Jan 2013 05:41:04 -0500
Received: by mail-wi0-f176.google.com with SMTP id hm6so2145474wib.3
        for <ceph-devel@vger.kernel.org>; Tue, 15 Jan 2013 02:41:02 -0800 (PST)
In-Reply-To: <50F52E4C.4000704@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

2013/1/15 Wido den Hollander <wido@widodh.nl>:
> Yes, no problem at all! That's where the crushmap is for. This way you can
> tell Ceph exactly how to distribute your data.

Cool.
If I understood properly, I have to configure ceph with OSD in a
standard way and then
map these osd into a custom crushmap like this:

host node1 {
        id -1
        alg straw
        hash 0
        item osd.0 weight 1.00
        item osd.1 weight 1.00
}

host node2 {
        id -2
        alg straw
        hash 0
        item osd.2 weight 1.00
        item osd.3 weight 1.00
}

rack rack1 {
        id -3
        alg straw
        hash 0
        item node1 weight 2.00
}

rack rack2 {
        id -4
        alg straw
        hash 0
        item node2 weight 2.00
}

This one should allow me to have 4 OSDs, 2 servers and 2 racks. Each
rack with one server with 2 OSDs
Data will be automatically striped across both rack, right?
