From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: FreeBSD Building and Testing
Date: Wed, 6 Jan 2016 13:41:31 +0100
Message-ID: <568D0B7B.2090203@digiware.nl>
References: <5676D2D9.5010600@digiware.nl>
 <CANE=7sVw1zhxYzT9q6WKkUV5tCioLuO0J_ZKCkdKXR5jFDHsKg@mail.gmail.com>
 <56785D9A.2020701@digiware.nl> <568168F0.2060605@digiware.nl>
 <20160106075144.GA3402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:46528 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751140AbcAFMln (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 6 Jan 2016 07:41:43 -0500
In-Reply-To: <20160106075144.GA3402@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mykola Golub <mgolub@mirantis.com>
Cc: =?UTF-8?B?WGluemUgQ2hpICjkv6Hms70p?= <xmdxcxz@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 6-1-2016 08:51, Mykola Golub wrote:
> 
> Are you able to reproduce this problem manually? I.e. in src dir, start the
> cluster using vstart.sh:
> 
> ./vstart.sh -n
> 
> Check it is running:
> 
> ./ceph -s
> 
> Repeat the test:
> 
> truncate -s 0 empty_map.txt
> ./crushtool -c empty_map.txt -o empty_map.map
> ./ceph osd setcrushmap -i empty_map.map
> 
> Expected output:
> 
>  "Error EINVAL: Failed crushmap test: ./crushtool: exit status: 1"
> 

Oke thanx....

Nice to have some of these examples...

--WjW

