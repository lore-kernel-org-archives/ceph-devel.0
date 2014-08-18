From: Dan Van Der Ster <daniel.vanderster@cern.ch>
Subject: Re: Stopping ceph daemons during the upgrade
Date: Mon, 18 Aug 2014 15:31:52 +0000
Message-ID: <A856D71F-CC6F-4A6A-B29B-FD19FB511482@cern.ch>
References: <53F21994.5000202@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx11.cern.ch ([188.184.36.50]:47373 "EHLO CERNMX11.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750762AbaHRPhY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Aug 2014 11:37:24 -0400
In-Reply-To: <53F21994.5000202@dachary.org>
Content-Language: en-US
Content-ID: <6392514FBC455E40AD18B54D4670B561@cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

On 18 Aug 2014, at 17:19, Loic Dachary <loic@dachary.org> wrote:

> there probably is a way to do something similar with RPM packages.=20

That behaviour (well, close enough) just _removed_ from firefly, see:
  https://github.com/ceph/ceph/commit/361c1f8554ce1fedfd0020cd306c41b0b=
a25f53e

I don=92t have a strong opinion if the pkg update should restart the da=
emon or not =97 but we should try not to change this too often as it ch=
anges our operating procedures.

Cheers, Dan--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
