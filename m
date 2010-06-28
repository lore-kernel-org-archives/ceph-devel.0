From: =?utf-8?Q?Alex=E2=80=8E_Nelson?= <ajnelson@cs.ucsc.edu>
Subject: Re: Chunk size in Ceph
Date: Mon, 28 Jun 2010 08:58:19 -0700
Message-ID: <59AE22D6-8E1B-478E-8F03-04791D9C4FCC@cs.ucsc.edu>
References: <201006281627.54957.cray@unix-ag.uni-kl.de> <i0aghl$7jd$1@dough.gmane.org>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mustang.nps.edu ([205.155.65.61]:53646 "EHLO mustang.nps.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751210Ab0F1QJf convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Jun 2010 12:09:35 -0400
In-Reply-To: <i0aghl$7jd$1@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

Hello all,

Sage informed me of the place where the default size is set a while back.  In src/config.cc, the struct g_default_file_layout has a few default size parameters.  He advised me that fl_stripe_unit and fl_object_size should be the same.  He also told me there's a way to set those on individual files, though that's potentially a pain and could be easier by just setting the default at compile time.

There's also a feature request in on alternate methods of setting these.  I'm sure the Ceph team would welcome input on this.

http://tracker.newdream.net/issues/185

--Alex


On Jun 28, 2010, at 08:53 , Thomas Mueller wrote:

> Am Mon, 28 Jun 2010 16:27:54 +0200 schrieb Christian Baun:
> 
>> Hi,
>> 
>> What is the chunk size of Ceph?
>> I couldn't find this information.
>> 
>> Best Regards
>>   Christian
> 
> IMHO 4mb 
> 
> found in first link if I google "ceph chunk size":
> http://lmgtfy.com/?q=ceph+chunk+size
> 
> (http://www.usenix.org/events/fast09/wips_posters/molina_wip.pdf)
> 
> :)
> 
> - Thomas
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

