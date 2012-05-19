From: Stefan Priebe <s.priebe@profihost.ag>
Subject: session lost, hunting for new mon
Date: Sat, 19 May 2012 07:22:48 +0200
Message-ID: <4FB72E28.2040709@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:51882 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752202Ab2ESFWs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 19 May 2012 01:22:48 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

while doing my first tests with ceph i'm always struggling about these 
kernel messages:

[  273.332472] libceph: client0 fsid d3aa8d88-3aa8-4f74-bb87-aa8de4975a84
[  273.351025] libceph: mon1 10.0.255.101:6789 session established
[  459.830296] libceph: mon1 10.0.255.101:6789 socket closed
[  459.847044] libceph: mon1 10.0.255.101:6789 session lost, hunting for 
new mon
[  472.226073] libceph: mon0 10.0.255.100:6789 session established

Always while stress testing the session to the mon's got lost. Any ideas?

Stefan
