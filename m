From: Wolfgang Hennerbichler <wolfgang.hennerbichler@risc-software.at>
Subject: Re: OSD memory leak when scrubbing [0.56.6]
Date: Wed, 22 May 2013 08:21:18 +0200
Message-ID: <519C63DE.7070404@risc-software.at>
References: <519B9196.5090402@filoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from email.edvz.uni-linz.ac.at ([140.78.3.65]:40063 "EHLO
	email.uni-linz.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754845Ab3EVGVG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 May 2013 02:21:06 -0400
In-Reply-To: <519B9196.5090402@filoo.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Oliver Francke <Oliver.Francke@filoo.de>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



On 05/21/2013 05:24 PM, Oliver Francke wrote:
> Well,

> 
> Not anyone else with perhaps large pg's experiencing such behaviour?

100pg's per pool, 3 pools. deep-scrub adds about 200M to every OSD, it
get's worse in time. it gets better when using syslog instead of direct
logging, interestingly enougy.

> Any advice on how to proceed?

in my cast it is: wait until they say: the cuttlefish swims into a
stable direction. and restart osd's every now and then...

> Thnx in advance,
> 
> Oliver.
> 


-- 
DI (FH) Wolfgang Hennerbichler
Software Development
Unit Advanced Computing Technologies
RISC Software GmbH
A company of the Johannes Kepler University Linz

IT-Center
Softwarepark 35
4232 Hagenberg
Austria

Phone: +43 7236 3343 245
Fax: +43 7236 3343 250
wolfgang.hennerbichler@risc-software.at
http://www.risc-software.at
