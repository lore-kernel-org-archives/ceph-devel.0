From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: SSD journal suggestion
Date: Wed, 07 Nov 2012 09:01:30 -0600
Message-ID: <509A77CA.5030206@inktank.com>
References: <CAJH6TXhecExbQKa-tO+VCFwH7k3oFVvdqZ3h=n5E4VoZfXe27w@mail.gmail.com> <alpine.DEB.2.00.1211070416530.23920@cobra.newdream.net> <CAJH6TXgrn2FVkYH=Tb67KnHJO-MWO0tKu8uNFUby=ZY-ibvLaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:44897 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754309Ab2KGPB1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Nov 2012 10:01:27 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so2458404iea.19
        for <ceph-devel@vger.kernel.org>; Wed, 07 Nov 2012 07:01:27 -0800 (PST)
In-Reply-To: <CAJH6TXgrn2FVkYH=Tb67KnHJO-MWO0tKu8uNFUby=ZY-ibvLaw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

On 11/07/2012 06:28 AM, Gandalf Corvotempesta wrote:
> 2012/11/7 Sage Weil <sage@inktank.com>:
>> On Wed, 7 Nov 2012, Gandalf Corvotempesta wrote:
>>> I'm evaluating some SSD drives as journal.
>>> Samsung 840 Pro seems to be the fastest in sequential reads and write.
>
> The 840 Pro seems to reach 485MB/s in sequential write:
> http://www.storagereview.com/samsung_ssd_840_pro_review
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

I'm using Intel 510s in a test node and can do about 450MB/s per drive. 
  Right now I'm doing 3 journals per SSD, but topping out at about 
1.2-1.4GB/s from the client perspective for the node with 15+ drives and 
5 SSDs.  It's possible newer versions of the code and tuning may 
increase that.

TV pointed me at the new Intel DC S3700 which looks like a very 
interesting option (the 100GB model for $240).

http://www.anandtech.com/show/6432/the-intel-ssd-dc-s3700-intels-3rd-generation-controller-analyzed

Mark
