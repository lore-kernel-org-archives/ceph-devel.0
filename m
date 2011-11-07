From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: Suggest to return [] when no image in the pool
Date: Mon, 07 Nov 2011 09:27:18 -0800
Message-ID: <4EB814F6.1090603@dreamhost.com>
References: <8512670932FB654F81AF0FEF1BE6D49D649E74@WHQBEMAIL1.whq.wistron> <CAF3hT9DaMW8dCx=1BGnW1jjoK+AuDDBNe57tfV1S2P3rc-BPUw@mail.gmail.com> <8512670932FB654F81AF0FEF1BE6D49D68DEDB@WHQBEMAIL1.whq.wistron>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:40494 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754814Ab1KGR1T (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Nov 2011 12:27:19 -0500
In-Reply-To: <8512670932FB654F81AF0FEF1BE6D49D68DEDB@WHQBEMAIL1.whq.wistron>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Eric_YH_Chen@wistron.com
Cc: ceph-devel@vger.kernel.org

On 11/07/2011 01:43 AM, Eric_YH_Chen@wistron.com wrote:
> Hi, developers,
>
> When I used the API in rbd.py,
>
> I found RBD().list(ioctx) would return [""] when there is no image in the pool.
>
> I suggest it should return [] in this case. It would avoid some programming problem. Thanks!
>
> regards,
>
> Eric/Pjack

Fixed by 34d80397f73a847f31aad6f00afd0eeb3d526ca0. Thanks for reporting 
this!

Josh
