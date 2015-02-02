From: Janne Grunau <j@jannau.net>
Subject: Re: gf_unit 16 A -1 -m SPLIT 16 4 -r ALTMAP - failure
Date: Mon, 2 Feb 2015 22:14:57 +0100
Message-ID: <20150202211457.GK2734@jannau.net>
References: <54B16763.7070602@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from soltyk.jannau.net ([5.9.120.237]:47673 "EHLO soltyk.jannau.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965028AbbBBVZc (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 2 Feb 2015 16:25:32 -0500
Content-Disposition: inline
In-Reply-To: <54B16763.7070602@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Kevin Greenan <kmgreen2@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 2015-01-10 18:54:43 +0100, Loic Dachary wrote:
> Hi Kevin & Janne,
> 
> The test gf_unit 16 A -1 -m SPLIT 16 4 -r ALTMAP - fails on the current gf-complete master. The first commit where it fails is
> 
> commit 474010a91d35fef5ca7dea77205b6a5c7e68c3e9
> Author: Janne Grunau <j@jannau.net>
> Date:   Wed Sep 17 16:10:25 2014 +0200
> 
>     arm: NEON optimisations for gf_w16
> 
>     Optimisations for the 4,16 split table region multiplications.
> 
>     Selected time_tool.sh 16 -A -B results for a 1.7 GHz cortex-a9:
>     Region Best (MB/s):   532.14   W-Method: 16 -m SPLIT 16 4 -r SIMD -
>     Region Best (MB/s):   212.34   W-Method: 16 -m SPLIT 16 4 -r NOSIMD -
>     Region Best (MB/s):   801.36   W-Method: 16 -m SPLIT 16 4 -r SIMD -r ALTMAP -
>     Region Best (MB/s):    93.20   W-Method: 16 -m SPLIT 16 4 -r NOSIMD -r ALTMAP -
>     Region Best (MB/s):   273.99   W-Method: 16 -m SPLIT 16 8 -
>     Region Best (MB/s):   270.81   W-Method: 16 -m SPLIT 8 8 -
>     Region Best (MB/s):    70.42   W-Method: 16 -m COMPOSITE 2 - -
>     Region Best (MB/s):   393.54   W-Method: 16 -m COMPOSITE 2 - -r ALTMAP -
> 
> but the test did exit(0) on error instead of exit(1) and we failed to notice.
> 
> gf_unit 16 A -1 -m SPLIT 16 4 -r ALTMAP -
> Args: 16 A -1 -m SPLIT 16 4 -r ALTMAP - / size (bytes): 524428
> Problem with region multiply (all values in hex):
>    Target address base: 0x8fd08e.  Word 0x1 of 0x1fee.  Xor: 0
>    Value: 2
>    Original source word: d00a
>    Product word: a000
>    It should be: b01f
> 
> Do you have an idea why this happens ? For the record here is the bisect command I used:

yes, it happens because the arm code is incomplete and bogus. I did the 
arm64 code first and then ported it to arm. This function uses arm64 
specific instructions and thus needed a port to arm. The arm version 
misses several computation steps. I guess I trusted the results of the
unit tests and didn't looked at gf_unit output on arm.

I'll send a fix tomorrow.

Janne
