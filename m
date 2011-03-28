From: Ben De Luca <bdeluca@gmail.com>
Subject: Re: Creating the filesystem and tweaking configurations
Date: Mon, 28 Mar 2011 21:00:44 +0100
Message-ID: <AANLkTik92T+jrdFieF1AbjzP5hsmrVkF=A_ASPU=gCpE@mail.gmail.com>
References: <loom.20110328T213028-664@post.gmane.org>
	<AANLkTi=F9KNJpgTu-TnkaE4R_oFnp03ZBLCDNRTgG1YA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64939 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754759Ab1C1UAp convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Mar 2011 16:00:45 -0400
Received: by bwz15 with SMTP id 15so2688637bwz.19
        for <ceph-devel@vger.kernel.org>; Mon, 28 Mar 2011 13:00:44 -0700 (PDT)
In-Reply-To: <AANLkTi=F9KNJpgTu-TnkaE4R_oFnp03ZBLCDNRTgG1YA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Steena Monteiro <steena.m@aggiemail.usu.edu>
Cc: ceph-devel@vger.kernel.org

Last I checked the lucid package was out of date, is that still the cas=
e?

> On Mon, Mar 28, 2011 at 8:54 PM, Steena Monteiro
> <steena.m@aggiemail.usu.edu> wrote:
>>
>> 1) I used apt-get to procure and install Ceph excluding the standalo=
ne
>> client on
>> Lucid Lynx. I obtained built the =A0client using instructions
>> on the Ceph wiki and
>> it worked fine after I reverted certain commits. However, mkcephfs (=
from:
>> $
>> /usr/sbin/mkcephfs -c /etc/ceph/ceph.conf --allhosts -v) has been
>> breaking:
>>
>> 2011-03-28 13:23:23.596948 b77b16d0 OSD::mkfs:
>> couldn't mount FileStore: error -95
>> 2011-03-28 13:23:23.597008 b77b16d0 =A0** ERROR:
>> error creating empty object store
>> in /data/osd0: error 95: Operation not supported
>> failed: '/usr/bin/cosd -c /etc/ceph/ceph.conf --monmap
>> /tmp/mkcephfs.DZdhzxPY5k/monmap.24380 -i 0 --mkfs --osd-data /data/o=
sd0'
>>
>> Additionally, I checked and /data/osd0 does exist...
>>
>> 2) I want to be able to tune Ceph's configuration
>> parameters (located in
>> config.cc within the Ceph source) and see how each
>> configuration change impacts Ceph's performance.
>> However, I am not certain how changes in the ceph source
>> code will be reflected in the standalone-client in terms of
>> Ceph's performance.
>> Is there a suggested way I could work to accomplish changing paramet=
ers in
>> the
>> source in order to have the file system impacted by these changes?
>>
>> I'd appreciate your help!
>>
>> Thanks in advance,
>> Steena
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
