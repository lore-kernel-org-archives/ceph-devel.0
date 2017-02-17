From: Vaibhav Bhembre <vaibhav@digitalocean.com>
Subject: Re: Are we ready for jewel 10.2.6?
Date: Fri, 17 Feb 2017 15:13:13 -0500
Message-ID: <20170217201313.GA49190@Vaibhavs-MacBook-Air.local>
References: <63289246-25fb-c96f-b844-dba82d7293c5@suse.cz>
 <CAC7t81bh9xOh77e73zXpHWhvWhPiMagTiER6LqpqqGfHiMqZrg@mail.gmail.com>
 <c8317af2-a8a2-2f22-7083-46f24057f10a@dachary.org>
 <CAF-wwdEb_afYCQgjH5XpBbvk3J+dzg+CJ-agK6KsFajzu2gA1w@mail.gmail.com>
 <CABZ+qqm5z=dxpvFZchuFGWVfWgnq3CVCCY9srckFg8P7BKhumA@mail.gmail.com>
 <469562479.10114.1487242836607@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:34801 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932303AbdBQUO0 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Feb 2017 15:14:26 -0500
Received: by mail-qk0-f181.google.com with SMTP id s186so54394756qkb.1
        for <ceph-devel@vger.kernel.org>; Fri, 17 Feb 2017 12:13:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <469562479.10114.1487242836607@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: Brad Hubbard <bhubbard@redhat.com>, Dan van der Ster <dan@vanderster.com>, Nathan Cutler <ncutler@suse.cz>, Loic Dachary <loic@dachary.org>, Alexey Sheplyakov <asheplyakov@mirantis.com>, Abhishek Lekshmanan <abhishek@suse.com>, ceph-devel@vger.kernel.org

Would it be possible to include http://tracker.ceph.com/issues/17821 
(i.e. https://github.com/ceph/ceph/pull/13496) into 10.2.6? 

On 02/16, Wido den Hollander wrote:
> 
> > Op 16 februari 2017 om 11:55 schreef Dan van der Ster <dan@vanderster.com>:
> > 
> > 
> > Hi guys,
> > 
> > How close is 10.2.6? It would be really nice if this one-liner could
> > be included: http://tracker.ceph.com/issues/18708
> > 
> 
> I checked, but there is/was no PR against the Jewel branch, only the one against master: https://github.com/ceph/ceph/pull/12973
> 
> So I doubt it will make it in.
> 
> Wido
> 
> 
> > Cheers, Dan
> > 
> > 
> > On Thu, Feb 9, 2017 at 6:10 AM, Brad Hubbard <bhubbard@redhat.com> wrote:
> > > https://github.com/ceph/ceph/pull/11410 maybe?
> > >
> > > On Fri, Feb 3, 2017 at 5:02 PM, Loic Dachary <loic@dachary.org> wrote:
> > >> Hi Alexey,
> > >>
> > >> On 02/03/2017 07:11 AM, Alexey Sheplyakov wrote:
> > >>> Hi,
> > >>>
> > >>>> I'm still merging RGW backports and there a few more miscellaneous backports still in the queue.
> > >>>
> > >>> Any chance to have https://github.com/ceph/ceph/pull/13004 included in 10.2.6?
> > >>
> > >> Thanks for rebasing it :-) It now needs to go through a round of testing, which may or may not happen. Note however that you can run the relevant rgw teuthology jobs to test this pull request and if they succeed it will be merged.
> > >>
> > >> Cheers
> > >>
> > >>>
> > >>> Best regards,
> > >>>       Alexey
> > >>> --
> > >>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > >>> the body of a message to majordomo@vger.kernel.org
> > >>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > >>>
> > >>
> > >> --
> > >> Loïc Dachary, Artisan Logiciel Libre
> > >> --
> > >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > >> the body of a message to majordomo@vger.kernel.org
> > >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > >
> > >
> > >
> > > --
> > > Cheers,
> > > Brad
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
