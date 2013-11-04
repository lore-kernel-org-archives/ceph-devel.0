From: Alphe Salas Michels <asalas@kepler.cl>
Subject: writing a ceph cliente for MS windows
Date: Mon, 04 Nov 2013 17:19:12 -0300
Message-ID: <52780140.6090409@kepler.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:64658 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748Ab3KDUTT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Nov 2013 15:19:19 -0500
Received: by mail-qa0-f53.google.com with SMTP id k4so520410qaq.5
        for <ceph-devel@vger.kernel.org>; Mon, 04 Nov 2013 12:19:18 -0800 (PST)
Received: from [192.168.0.44] ([200.111.172.141])
        by mx.google.com with ESMTPSA id ge5sm50951283qeb.5.2013.11.04.12.19.13
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 04 Nov 2013 12:19:17 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Good day developers!

I would like to propose to the one interested  work with me to develop a 
ceph cliente for MS windows world, Basing us on dokanFS.

My company is a ceph enthousiast that use on a dayly basis ceph and that 
need both transfer speed and big expendable and cheap storage.
My company is specialised in data recovery and we want to participate to 
ceph effort by bringing a ceph cliente for windows.
Our experience shows us that the best gateway is each clientes being its 
own gateway, instead of having a bottle neck server or a cluster of 
bottle neck servers as gateway (FTP, samba, SFTP,webdav, s3, etc..).

We already did some research in that domain.

Dokan FS is an intent  to write an opensource fuse like cliente for MS 
windows.

More information on DOKANFS can be triggered here
http://dokan-dev.net/en/download/

Positive points of using DOKANFS.

- its opensourced and well licenced mit licence, gpl licence and lgpl 
licence.

Negative point of using DOKAN FS.
- unreachable author
- Poor documentation . Dev comments in japanese.
- Work in progress so it is unstable and needs to be updated, debugged 
and maintained by a MS Windows file system expert developper.

I try past year to do a merge from ceph-fuse to dokanfs
here are what I learnt.
- Ceph-fuse and related source code is around 60 000 lines of code.
- Ceph protocol isn t documented so it is like trying to draw a map of 
america using only a sextan and a compass.

Those led me to those conclusions:
- I can t do it alone.
- It is easier to draw down the ceph protocol way to work from 
kernel/fs/ceph sources and mount.ceph
- Ceph depending libraries may be unexistant or not up to date in their 
port on MS Windows (cygwin)
- MS file system specialist are hard do find in the "open source libre 
world" so I will try in the commercial world.

The commercial world has some problems too. They need ceph protocol 
draft to implemente it to their own product They will have licencing 
/commercial politics that infringe lgpl, and hide that most of the work 
is done by people other than them. They will not participate in a 
financial way to ceph enhancement and growth.

As for the modalities of the work if we come to work togather on that 
topic, it up to you. We can / should use the most possible libre tools 
for that work (eclipse, mingwin/cygwin etc...) Sharpening the dev tools 
in libre can already be a big problem. But my way to see this is the 
more libre are our tools on MS Windows the most people can easyly join us.


Best Regards,


Alphe Salas

asalas@kepler.cl
I.T ingeneer.
*<http://www.kepler.cl>*

