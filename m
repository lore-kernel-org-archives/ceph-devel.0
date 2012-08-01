From: Ryan Nicholson <Ryan.Nicholson@kcrg.com>
Subject: RE: Quick CentOS/RHEL question ...
Date: Wed, 1 Aug 2012 00:48:22 +0000
Message-ID: <F5955DC568F9AF4DB00BE0F7E950BE0C0E90970F@BLUPRD0411MB438.namprd04.prod.outlook.com>
References: <50185964.3010803@scalableinformatics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ch1ehsobe006.messaging.microsoft.com ([216.32.181.186]:4070
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751835Ab2HAAs1 convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 31 Jul 2012 20:48:27 -0400
In-Reply-To: <50185964.3010803@scalableinformatics.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "landman@scalableinformatics.com" <landman@scalableinformatics.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Joseph:

I happen to be using strictly CentOS 6.2 x64 - as this is supported by Dell and their openmanage packages. There are several libraries that you will need to download and compile on top of what is already in the CentOS Repos.

Here's the list of what I had to build:

* gperftools-2.0.tar.gz - http://code.google.com/p/gperftools/downloads/list
* cryptopp561.zip - http://www.cryptopp.com/
* libunwind-0.99.tar.gz - http://download.savannah.gnu.org/releases/libunwind/
And, of course I'm using Ceph, Argonaut revision (ceph-0.48argonaut.tar.gz)

Any other packages came with the CentOS repos, and were found either using yum provides or yum search.

I don't recall in which order to build these, but make sure that they install in your desired prefix (using ./configure PREFIX=/usr for example) I forgot to build ceph using the prefix command and libraries have been an issue, since everything is in /usr/local/... My Mistake. It looks as though the dev's use PREFIX=/usr for all of their builds.


I hope this helps.

Ryan Nicholson


-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Joe Landman
Sent: Tuesday, July 31, 2012 5:17 PM
To: ceph-devel@vger.kernel.org
Subject: Quick CentOS/RHEL question ...

Hi folks

   I was struggling and failing to get Ceph properly built/installed for CentOS 6 (and 5) last week.  Is this simply not a recommended platform? 
  Please advise.  Thanks!



-- 
Joseph Landman, Ph.D
Founder and CEO
Scalable Informatics Inc.
email: landman@scalableinformatics.com
web  : http://scalableinformatics.com
        http://scalableinformatics.com/sicluster
phone: +1 734 786 8423 x121
fax  : +1 866 888 3112
cell : +1 734 612 4615
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


