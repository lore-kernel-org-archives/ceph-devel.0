From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: RE: CEPH Erasure Encoding + OSD Scalability
Date: Sun, 22 Sep 2013 23:00:12 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4A527352B@PLOXCHG03.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx32.cern.ch ([137.138.144.178]:14599 "EHLO
	CERNMX32.cern.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752393Ab3IVXAR convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 22 Sep 2013 19:00:17 -0400
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Loic, 
I was applying the changes and the 
situation improves, however there is still one important thing which 
actually dominated all the measurements which were needing larger packet
 sizes (everything besides Raid6):

                     pad_in_length(unsigned in_length)


The implementation is sort of 'unlucky' and slow when one increases the packetsize.

   while (in_length%(k*w*packetsize*sizeof(int)) != 0)
      in_length++;

better do like this:

  alignment = k*w*packetsize*sizeof(int);
  in_length += (alignment - (in_length%alignment);

E.g. for the CauchyGood algorithm one should increase the packetsize and when changing the pad_in_length 
implementation one get's excellent (pure encoding) performance for (3+2) : 2.6 GB/s and it scales well with the number of core's to > 8 GB/s.

I compared this with the output of the 'encode' example of the jerasure
 example and it gives the same result for (3+2), so that looks now good 
and consistent! (10,4) is ~ 610 MB/s.

... 
Finally the description of Jerasure 2.0 looks really great and will probably shift all the performance problems upstream  ;-)

Do you evt. want to add support into the plugin for local parities (like Xorbas does) to improve the disk draining performance?

Cheers Andreas.