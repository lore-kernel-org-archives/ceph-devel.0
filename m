From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: Infiniband 40GB
Date: Wed, 06 Jun 2012 12:48:44 +0200
Message-ID: <4FCF358C.6080301@profihost.ag>
References: <4FCB1C0A.4050504@profihost.ag> <CADdPHGvgE7ai6yjzsKmL9bfqEpyx+qxQaUKoOOYjiT4ZCJ-A0g@mail.gmail.com> <4FCC7E34.7040005@univ-nantes.fr> <201206041147.22993.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:46349 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329Ab2FFKss (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Jun 2012 06:48:48 -0400
In-Reply-To: <201206041147.22993.a.ott@m-privacy.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amon Ott <a.ott@m-privacy.de>
Cc: Yann Dupont <Yann.Dupont@univ-nantes.fr>, ceph-devel@vger.kernel.org

Hi Amon,

i've added your patch:
# strings /lib/libc-2.11.3.so |grep -i syncfs
syncfs

But configure of ceph still claims there is no syncfs support.

# ./configure |grep -i sync
checking for syncfs... no
checking for sync_file_range... yes

Any ideas?

Hint: I'm compiling my packages on an OpenVZ RHEL6 based virtual 
container - so THIS kernel where i'm compiling does not support syncfs 
is this the reason?

Stefan
