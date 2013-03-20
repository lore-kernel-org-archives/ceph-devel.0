From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH 21/39] mds: encode dirfrag base in cache rejoin ack
Date: Wed, 20 Mar 2013 16:40:28 -0700
Message-ID: <CAPYLRzjZvweZTh4iaPw81q+kUegaByWKGp=Uk=40WQd1dQQj8Q@mail.gmail.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
	<1363531902-24909-22-git-send-email-zheng.z.yan@intel.com>
	<CAPYLRzjwL43cDez1aC7x_m7E71Udrus3vqm1+j1f4O+0MmG5+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f52.google.com ([209.85.216.52]:48486 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054Ab3CTXk3 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Mar 2013 19:40:29 -0400
Received: by mail-qa0-f52.google.com with SMTP id bs12so1378159qab.18
        for <ceph-devel@vger.kernel.org>; Wed, 20 Mar 2013 16:40:29 -0700 (PDT)
In-Reply-To: <CAPYLRzjwL43cDez1aC7x_m7E71Udrus3vqm1+j1f4O+0MmG5+w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

On Wed, Mar 20, 2013 at 4:33 PM, Gregory Farnum <greg@inktank.com> wrot=
e:
> This needs to handle versioning the encoding based on peer feature bi=
ts too.
>
> On Sun, Mar 17, 2013 at 7:51 AM, Yan, Zheng <zheng.z.yan@intel.com> w=
rote:
>> +  void add_dirfrag_base(CDir *dir) {
>> +    ::encode(dir->dirfrag(), dirfrag_base);
>> +    bufferlist bl;
>> +    dir->_encode_base(bl);
>> +    ::encode(bl, dirfrag_base);
>> +  }
>
> We are guilty of doing this in other places, but we should avoid
> implicit encodings like this one, especially when the decode happens
> somewhere else like it does here. We can make a vector dirfrag_bases
> and add to that, and then encode and decode it along with the rest of
> the message =97 would that work for your purposes?
> -Greg

Sorry, a vector (called dirfrag_bases) of pair<dirfrag_t, bl> where bl
is the encoded base. Or something like that. :)
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
