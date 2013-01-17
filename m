From: Dan Mick <dan.mick@inktank.com>
Subject: Re: ceph-osd can`t start after crush server
Date: Thu, 17 Jan 2013 13:30:09 -0800
Message-ID: <50F86D61.90806@inktank.com>
References: <50F6406B.3020906@nazarianin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:33951 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755033Ab3AQVaN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jan 2013 16:30:13 -0500
Received: by mail-pb0-f52.google.com with SMTP id ro2so1628263pbb.11
        for <ceph-devel@vger.kernel.org>; Thu, 17 Jan 2013 13:30:12 -0800 (PST)
In-Reply-To: <50F6406B.3020906@nazarianin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "aleonov@nazarianin.com" <aleonov@nazarianin.com>
Cc: ceph-devel@vger.kernel.org

Did you have any logging on at the time?  If not, can you turn on
debug ms = 1, debug osd = 20 and try again, and collect the osd log?


On 01/15/2013 09:53 PM, aleonov@nazarianin.com wrote:
>      Hello All
> Ceph-osd can`t start after crush server. I use XFS for osd folder.
>
> Best regards,
>                       Aleksey Leonov
>
> /usr/bin/ceph-osd -i 1 --pid-file /var/run/ceph/osd.1.pid -c
> /etc/ceph/ceph.conf -d
> 2013-01-16 11:20:57.994965 7f73b089e780  0 ceph version 0.56.1
> (e4a541624df62ef353e754391cbbb707f54b16f7), process ceph-osd, pid 20960
> starting osd.1 at :/0 osd_data /ceph/osd/osd.1 /ceph/osd/osd.1/journal
> 2013-01-16 11:20:58.068506 7f73b089e780  0 filestore(/ceph/osd/osd.1)
> mount FIEMAP ioctl is supported and appears to work
> 2013-01-16 11:20:58.068538 7f73b089e780  0 filestore(/ceph/osd/osd.1)
> mount FIEMAP ioctl is disabled via 'filestore fiemap' config option
> 2013-01-16 11:20:58.068940 7f73b089e780  0 filestore(/ceph/osd/osd.1)
> mount did NOT detect btrfs
> 2013-01-16 11:20:58.081290 7f73b089e780  0 filestore(/ceph/osd/osd.1)
> mount syncfs(2) syscall fully supported (by glibc and kernel)
> 2013-01-16 11:20:58.081424 7f73b089e780  0 filestore(/ceph/osd/osd.1)
> mount found snaps <>
> 2013-01-16 11:20:58.113247 7f73b089e780  0 filestore(/ceph/osd/osd.1)
> mount: enabling WRITEAHEAD journal mode: btrfs not detected
> 2013-01-16 11:20:58.118473 7f73b089e780  1 journal _open
> /ceph/osd/osd.1/journal fd 19: 1048576000 bytes, block size 4096 bytes,
> directio = 1, aio = 0
> 2013-01-16 11:20:58.118632 7f73b089e780  1 journal _open
> /ceph/osd/osd.1/journal fd 19: 1048576000 bytes, block size 4096 bytes,
> directio = 1, aio = 0
> 2013-01-16 11:20:58.120640 7f73b089e780  1 journal close
> /ceph/osd/osd.1/journal
> *** Caught signal (Segmentation fault) **
>   in thread 7f73b089e780
>   ceph version 0.56.1 (e4a541624df62ef353e754391cbbb707f54b16f7)
>   1: /usr/bin/ceph-osd() [0x7edcc4]
>   2: (()+0x10460) [0x7f73b028c460]
>   3: (std::vector<__gnu_cxx::_Hashtable_node<std::pair<pg_t const, PG*>
>  >*, std::allocator<__gnu_cxx::_Hashtable_node<std::pair<pg_t const,
> PG*> >*>
>  >::_M_fill_insert(__gnu_cxx::__normal_iterator<__gnu_cxx::_Hashtable_node<std::pair<pg_t const, PG*> >**, std::vector<__gnu_cxx::_Hashtable_node<std::pair<pg_t const, PG*> >*, std::allocator<__gnu_cxx::_Hashtable_node<std::pair<pg_t const, PG*> >*> > >, unsigned long, __gnu_cxx::_Hashtable_node<std::pair<pg_t const, PG*> >* const&)+0x70) [0x69bdd0]
>   4: (OSD::OSD(int, Messenger*, Messenger*, Messenger*, Messenger*,
> MonClient*, std::string const&, std::string const&)+0xdd9) [0x67d889]
>   5: (main()+0x3df4) [0x59bb84]
>   6: (__libc_start_main()+0xfd) [0x7f73ae4444bd]
>   7: /usr/bin/ceph-osd() [0x597989]
> Segmentation fault
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
