From: Vasu Kulkarni <vakulkar@redhat.com>
Subject: Re: [Ceph-ansible] EXT: Re: osd-directory scenario is used by us
Date: Tue, 9 May 2017 13:54:34 -0700
Message-ID: <CAKPXa=bfp9iXRe4Yq16XjZQEXEs+7x12C692a=zF2Z6ABmP4Qg@mail.gmail.com>
References: <D52531DE.26501%michael.gugino@walmart.com> <CABq-AyS+kuFd15dJ1dZMBkEOcDM6XNV7cXquTWXX6=jLeOb2gw@mail.gmail.com>
 <CA+HUO7L2L-z_FerkqzHTJbP9KVZAgkg7853EgMDwy8YrUvLw_w@mail.gmail.com> <CAKPXa=Y8bXezvEmP5RKgxFnAHnZfBfR0XQkkUZUHZhhg80Vuxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:33348 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750911AbdEIUyf (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 9 May 2017 16:54:35 -0400
Received: by mail-pg0-f53.google.com with SMTP id u187so5514294pgb.0
        for <ceph-devel@vger.kernel.org>; Tue, 09 May 2017 13:54:35 -0700 (PDT)
In-Reply-To: <CAKPXa=Y8bXezvEmP5RKgxFnAHnZfBfR0XQkkUZUHZhhg80Vuxg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sebastien Han <shan@redhat.com>
Cc: Gregory Meno <gmeno@redhat.com>, Michael Gugino <Michael.Gugino@walmart.com>, ceph-devel <ceph-devel@vger.kernel.org>, "ceph-ansible@lists.ceph.com" <ceph-ansible@lists.ceph.com>

Sorry, sending as text

On Tue, May 9, 2017 at 1:51 PM, Vasu Kulkarni <vakulkar@redhat.com> wrote:
>
>
>
> On Tue, May 9, 2017 at 12:54 PM, Sebastien Han <shan@redhat.com> wrote:
>>
>> I just think that if we remove this from ceph-ansible (e.g: because
>> this is a scenario we don't want to support anymore), then perhaps we
>> should remove it from ceph-disk and ceph-deploy too.

 AFAIK it is not really documented for ceph-deploy
http://docs.ceph.com/docs/master/rados/deployment/ceph-deploy-osd/#activate-osds,
so it is for *testing* purpose only.

>>
>> Moreover, with
>> Bluestore, that feature will naturally go away ultimately.
>> What do you think?
>>
>> On Wed, May 3, 2017 at 6:17 PM, Gregory Meno <gmeno@redhat.com> wrote:
>> > Haven't seen any comments in a week. I'm going to cross-post this to ceph-devel
>> >
>> > Dear ceph-devel in an effort to simplify ceph-ansible I removed the
>> > code that sets up directory backed OSDs. We found our that it was
>> > being used in the following way.
>> >
>> > I would like to hear thoughts about this approach pro and con.
>> >
>> > cheers,
>> > G
>> >
>> > On Tue, Apr 25, 2017 at 2:12 PM, Michael Gugino
>> > <Michael.Gugino@walmart.com> wrote:
>> >> All,
>> >>
>> >>   Thank you for the responses and consideration.  What we are doing is
>> >> creating lvm volumes, mounting them, and using the mounts as directories
>> >> for ceph-ansible.  Our primary concern is the use of lvmcache.  We’re
>> >> using faster drives for the cache and slower drives for the backing
>> >> volumes.
>> >>
>> >>   We try to keep as few local patches as practical, and our initial
>> >> rollout of lvmcache + ceph-ansible steered us towards osd_directory
>> >> scenario.  Currently, ceph-ansible does not allow use to use lvm in the
>> >> way that we desire, but we are looking into submitting a PR to go that
>> >> direction (at some point).
>> >>
>> >>   As far as using the stable branches, I’m not entirely sure what our
>> >> strategy going forward will be.  Currently we are maintaining ceph-ansible
>> >> branches based on ceph releases, not ceph-ansible releases.
>> >>
>> >>
>> >> Michael Gugino
>> >> Cloud Powered
>> >> (540) 846-0304 Mobile
>> >>
>> >> Walmart ✻
>> >> Saving people money so they can live better.
>> >>
>> >>
>> >>
>> >>
>> >>
>> >> On 4/25/17, 4:51 PM, "Sebastien Han" <shan@redhat.com> wrote:
>> >>
>> >>>One other argument to remove the osd directory scenario is BlueStore.
>> >>>Luminous is around the corner and we strongly hope it'll be the
>> >>>default object store.
>> >>>
>> >>>On Tue, Apr 25, 2017 at 7:40 PM, Gregory Meno <gmeno@redhat.com> wrote:
>> >>>> Michael,
>> >>>>
>> >>>> I am naturally interested in the specifics of your use-case and would
>> >>>> love to hear more about it.
>> >>>> I think the desire to remove this scenario from the stable-2.2 release
>> >>>> is low considering what you just shared.
>> >>>> Would it be fair to ask that sharing your setup be the justification
>> >>>> for restoring this functionality?
>> >>>> Are you using the stable released bits already? I recommend doing so.
>> >>>>
>> >>>> +Seb +Alfredo
>> >>>>
>> >>>> cheers,
>> >>>> Gregory
>> >>>>
>> >>>> On Tue, Apr 25, 2017 at 10:08 AM, Michael Gugino
>> >>>> <Michael.Gugino@walmart.com> wrote:
>> >>>>> Ceph-ansible community,
>> >>>>>
>> >>>>>   I see that recently osd-directory scenario was removed from
>> >>>>>deployment
>> >>>>> options.  We use this option in production, I will be submitting a
>> >>>>>patch
>> >>>>> and a small fix to re-add that scenario.  We believe our use-case is
>> >>>>> non-trivial, and we are hoping to share our setup with the community in
>> >>>>> the near future once we get approval.
>> >>>>>
>> >>>>> Thank you
>> >>>>>
>> >>>>>
>> >>>>> Michael Gugino
>> >>>>> Cloud Powered
>> >>>>> (540) 846-0304 Mobile
>> >>>>>
>> >>>>> Walmart ✻
>> >>>>> Saving people money so they can live better.
>> >>>>>
>> >>>>>
>> >>>>>
>> >>>>>
>> >>>>>
>> >>>>> On 4/18/17, 3:41 PM, "Ceph-ansible on behalf of Sebastien Han"
>> >>>>> <ceph-ansible-bounces@lists.ceph.com on behalf of shan@redhat.com>
>> >>>>>wrote:
>> >>>>>
>> >>>>>>Hi everyone,
>> >>>>>>
>> >>>>>>We are close from releasing the new ceph-ansible stable release.
>> >>>>>>We are currently in a heavy QA phase where we are pushing new tags in
>> >>>>>>the format of v2.2.x.
>> >>>>>>The latest tag already points to stable-2.2 branch.
>> >>>>>>
>> >>>>>>Stay tuned, stable-2.2 is just around the corner.
>> >>>>>>Thanks!
>> >>>>>>
>> >>>>>>--
>> >>>>>>Cheers
>> >>>>>>
>> >>>>>>––––––
>> >>>>>>Sébastien Han
>> >>>>>>Principal Software Engineer, Storage Architect
>> >>>>>>
>> >>>>>>"Always give 100%. Unless you're giving blood."
>> >>>>>>
>> >>>>>>Mail: seb@redhat.com
>> >>>>>>Address: 11 bis, rue Roquépine - 75008 Paris
>> >>>>>>_______________________________________________
>> >>>>>>Ceph-ansible mailing list
>> >>>>>>Ceph-ansible@lists.ceph.com
>> >>>>>>http://lists.ceph.com/listinfo.cgi/ceph-ansible-ceph.com
>> >>>>>
>> >>>>> _______________________________________________
>> >>>>> Ceph-ansible mailing list
>> >>>>> Ceph-ansible@lists.ceph.com
>> >>>>> http://lists.ceph.com/listinfo.cgi/ceph-ansible-ceph.com
>> >>>
>> >>>
>> >>>
>> >>>--
>> >>>Cheers
>> >>>
>> >>>––––––
>> >>>Sébastien Han
>> >>>Principal Software Engineer, Storage Architect
>> >>>
>> >>>"Always give 100%. Unless you're giving blood."
>> >>>
>> >>>Mail: seb@redhat.com
>> >>>Address: 11 bis, rue Roquépine - 75008 Paris
>> >>
>> > _______________________________________________
>> > Ceph-ansible mailing list
>> > Ceph-ansible@lists.ceph.com
>> > http://lists.ceph.com/listinfo.cgi/ceph-ansible-ceph.com
>>
>>
>>
>> --
>> Cheers
>>
>> ––––––
>> Sébastien Han
>> Principal Software Engineer, Storage Architect
>>
>> "Always give 100%. Unless you're giving blood."
>>
>> Mail: seb@redhat.com
>> Address: 11 bis, rue Roquépine - 75008 Paris
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
