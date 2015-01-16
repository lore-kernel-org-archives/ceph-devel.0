From: Wido den Hollander <wido@42on.com>
Subject: Re: 'Immutable bit' on pools to prevent deletion
Date: Fri, 16 Jan 2015 21:45:01 +0100
Message-ID: <173298809.14343.1421441101815.open-xchange@websrv.42on.com>
References: <54B7D2D6.4020503@42on.com> <CABBk=J9BVNzKHfSxdxmRjrZoasAWUz8_e9Juzc4vYnNXo0wHFA@mail.gmail.com> <alpine.DEB.2.00.1501150918110.26676@cobra.newdream.net> <101AEAEE-F428-4425-87CE-A20B3030FF55@enovance.com> <54B8EE3B.70506@42on.com> <597309080.14312.1421421468640.open-xchange@websrv>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:42492 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753185AbbAPUpE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Jan 2015 15:45:04 -0500
In-Reply-To: <597309080.14312.1421421468640.open-xchange@websrv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Sebastien Han <sebastien.han@enovance.com>, Yehuda Sadeh <yehuda@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>





> Op 16 jan. 2015 om 15:47 heeft Sage Weil <sage@newdream.net> het volgende geschreven:
> 
>> On Fri, 16 Jan 2015, Wido den Hollander wrote:
>>> On 01/16/2015 10:50 AM, Sebastien Han wrote:
>>> Hum if I understand correctly you?re all more in favour of a conf setting in the ceph.conf;
>>> The problem for me is that this will apply to all the pools by default and I?ll have to inject an arg to change this.
>>> Injecting the arg will remove this ?lock" and then all of the sudden all the pools become deletable through the lib again (who knows what users can do simultaneously)
>> 
>> No, from what I understand it's easier to implement, not the better way.
> 
> I'd like to do both, actually.  :)
> 

Sounds good!

>>> I?m more in favour of a new flag to set to the pool, something like:
>>> 
>>> ceph osd pool set foo protect true
>>> ceph osd pool delete foo foo ?yes?.
>>> ERROR: pool foo is protected against deletion
>>> 
>>> ceph osd pool delete foo protect false
>>> ceph osd pool delete foo foo ?yes?.
>>> Pool successfully deleted
>> 
>> Something like that per pool seems better to me as well. But I'd then
>> opt for a 'feature' which can be set on a pool.
>> 
>> ceph osd pool set foo nodelete
>> ceph osd pool set foo nopgchange
>> ceph osd pool set foo nosizechange
> 
> I like this since it fits into the current flags nicely.  The downside is 
> we don't grandfather existing pools on upgrade.  Not sure if people think 
> that's a good idea.
> 
>>> The good thing with that is that owners of the pool (or admin), will be able to set this flag or remove it.
>>> We stick with the "ceph osd pool delete foo foo ?yes?.? command as well, so we don?t change too much things.
>>> 
>>> Moreover we can also make use of a config option to protect all new created pools by default:
>>> 
>>> mon protect pool default = true
>>> 
>>> This automatically set the protected flag to a new pool.
>>> 
>>> What do you think?
>> 
>> Setting a nodelete flag or something like that by default is fine with
>> me. Like Sage mentioned earlier, almost nobody will have ephemeral pools
>> in their cluster. You don't want to loose data because you accidentally
>> removed a pool.
> 
> We should mirror this option:
> 
> OPTION(osd_pool_default_flag_hashpspool, OPT_BOOL, true)   // use new pg 
> hashing to prevent pool/pg overlap
> 
> So,
> 
> osd_pool_default_flag_nodelete = true
> osd_pool_default_flag_nopgchange = true
> osd_pool_default_flag_nosizechange = true
> 
> The big question for me is should we enable these by default in hammer?
> 

I would say yes. We should probably protect users against something stupid which makes them loose data.

Data safety is prio #1

Wido


> sage
> 
> 
> 
>> 
>> Wido
>> 
>>>> On 15 Jan 2015, at 18:24, Sage Weil <sage@newdream.net> wrote:
>>>> 
>>>> Then secondary question is whether the cluster should implicitly clear the 
>>>> allow-delete after some time period (maybe 'pending-delete' would make 
>>>> more sense in that case), or whether we deny IO during that period.  Seems 
>>>> perhaps too complicated.
>>> 
>>> 
>>> Cheers.
>>> ???? 
>>> S?bastien Han 
>>> Cloud Architect 
>>> 
>>> "Always give 100%. Unless you're giving blood."
>>> 
>>> Phone: +33 (0)1 49 70 99 72 
>>> Mail: sebastien.han@enovance.com 
>>> Address : 11 bis, rue Roqu?pine - 75008 Paris
>>> Web : www.enovance.com - Twitter : @enovance
>> 
>> 
>> -- 
>> Wido den Hollander
>> 42on B.V.
>> Ceph trainer and consultant
>> 
>> Phone: +31 (0)20 700 9902
>> Skype: contact42on
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
