From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: releasing jewel v10.2.3 ?
Date: Fri, 19 Aug 2016 13:09:36 +0200 (CEST)
Message-ID: <1721964598.277894.1471604976950.JavaMail.zimbra@oxygem.tv>
References: <57B698D0.1050409@dachary.org> <1074794425.66535.1471591086293.JavaMail.open-xchange@ox03.mail.pcextreme.nl> <423689760.277585.1471603036158.JavaMail.zimbra@oxygem.tv> <57B6E6DC.6030008@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.211.110]:41928 "EHLO
        mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751599AbcHSLKC (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Aug 2016 07:10:02 -0400
In-Reply-To: <57B6E6DC.6030008@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Wido den Hollander <wido@42on.com>, Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>

>>If you can run a rbd job that is relevant it will speedup backporting. 

Ok, thanks ! I'll try to do it Monday.

----- Mail original -----
De: "Loic Dachary" <loic@dachary.org>
À: "aderumier" <aderumier@odiso.com>, "Wido den Hollander" <wido@42on.com>
Cc: "Sage Weil" <sweil@redhat.com>, "ceph-devel" <ceph-devel@vger.kernel.org>, "Abhishek Varshney" <abhishek.varshney@flipkart.com>
Envoyé: Vendredi 19 Août 2016 13:00:44
Objet: Re: releasing jewel v10.2.3 ?

Hi Alexandre, 

On 19/08/2016 12:37, Alexandre DERUMIER wrote: 
> Hi, 
> 
> Personnaly I'm waiting for theses backports for librbd: 
> 
> "jewel: mkfs.xfs slow performance with discards and object map" 
> http://tracker.ceph.com/issues/16867 

I think it will be merged before 10.2.3 is released. 

> 
> "jewel: Discard hangs when 'rbd_skip_partial_discard' is enabled" 
> http://tracker.ceph.com/issues/16869 

This one was conflicting and did not get tested yet. I rebased it a minute ago and it will hopefully compile now. If you can run a rbd job that is relevant it will speedup backporting. 

Cheers 

> 
> Alexandre 
> 
> ----- Mail original ----- 
> De: "Wido den Hollander" <wido@42on.com> 
> À: "Loic Dachary" <loic@dachary.org> 
> Cc: "Sage Weil" <sweil@redhat.com>, "ceph-devel" <ceph-devel@vger.kernel.org>, "Abhishek Varshney" <abhishek.varshney@flipkart.com> 
> Envoyé: Vendredi 19 Août 2016 09:18:05 
> Objet: Re: releasing jewel v10.2.3 ? 
> 
>> Op 19 aug. 2016 om 07:28 heeft Loic Dachary <loic@dachary.org> het volgende geschreven: 
>> 
>> Hi Sage, 
>> 
>> Here are the issues that would be in jewel v10.2.3 if we decided to release it now: http://tracker.ceph.com/versions/518 
>> And here is the backport queue : http://tracker.ceph.com/projects/ceph/issues?query_id=96 
>> 
>> Do you think it is time to cut the release and ask QE to start testing ? 
>> 
> 
> I think that this one is a good candidate to go in as well. Since 10.2.4 can take a while. 
> 
> http://tracker.ceph.com/issues/17023 / https://github.com/ceph/ceph/pull/10725 
> 
> Nasty one which might catch users and leave them wondering why the OSDs are not coming up. 
> 
> Wido 
> 
>> Cheers 
>> 
>> -- 
>> LoÃ¯c Dachary, Artisan Logiciel Libre 
>> 
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in 
>> the body of a message to majordomo@vger.kernel.org 
>> More majordomo info at http://vger.kernel.org/majordomo-info.html 
> N�����r��y���b�X��ǧv�^�)޺{.n�+���z�]z���{ay�ʇڙ�,j��f���h���z��w������j:+v���w�j�m��������zZ+�����ݢj"��!�i 
> 
> 

-- 
Loïc Dachary, Artisan Logiciel Libre 

