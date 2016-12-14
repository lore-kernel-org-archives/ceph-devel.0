From: Mykola Golub <mgolub@mirantis.com>
Subject: Re: Cinder doesn't work with the current rados python bindings
Date: Wed, 14 Dec 2016 11:44:31 +0200
Message-ID: <20161214094429.GA8416@gmail.com>
References: <CA+hcxJS_wKucTUetNxPrHTn2j0V6vDUjCwKUTxp176xoCmSmVw@mail.gmail.com>
 <CA+aFP1Bz_=HPVnJTJa29NJMmvzX7_gSA3EEB2n5VZLctBU4tKA@mail.gmail.com>
 <CA+hcxJTBWk0VXYBdL7zLxWJTU6VfrT8RWL7W3e53ycHYUwqXyQ@mail.gmail.com>
 <CA+aFP1BnR-U_gFAR8zbgh3AnEk-SaLU1ucDA9AD5gu-t_UwxnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f175.google.com ([209.85.216.175]:33089 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755170AbcLNJoe (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Dec 2016 04:44:34 -0500
Received: by mail-qt0-f175.google.com with SMTP id p16so12947125qta.0
        for <ceph-devel@vger.kernel.org>; Wed, 14 Dec 2016 01:44:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CA+aFP1BnR-U_gFAR8zbgh3AnEk-SaLU1ucDA9AD5gu-t_UwxnA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: dillaman@redhat.com
Cc: Victor Denisov <vdenisov@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>

Could we add to API something like below?

  int rbd_get_default_features(rados_ioctx_t ioctx, uint64_t *features);

or

  uint64_t rbd_get_default_features(rados_ioctx_t ioctx);

(depending on if we want to fail when rbd_default_features is
specified incorrectly in config file).

This would reduced code duplication (rbd::utils::parse_rbd_default_features
and librbd::utils::parse_rbd_default_features), could be used by cinder,
and might be helpful for other users, who would want just to add a
necessary future to the default ones when creating an image:
 
  features = rbd_get_default_features(ioctx);
  features |= RBD_FEATURE_JOURNALING;
  rbd_create(..., features);

On Tue, Dec 13, 2016 at 07:24:02PM -0500, Jason Dillaman wrote:
> I actually already opened a ticket for this [1] and started to fix it
> since I would consider this a release blocker for Kraken.
> 
> [1] http://tracker.ceph.com/issues/18247
> 
> On Tue, Dec 13, 2016 at 7:10 PM, Victor Denisov <vdenisov@mirantis.com> wrote:
> > Yes. This is exactly the line I mean.
> > Is there any chance I can do it myself?
> > What kind of change is required?
> > I can unblock the cinder guy as well as contribute.
> > Let me know if I can be useful.
> >
> > Thanks.
> > V.
> >
> > On Tue, Dec 13, 2016 at 1:38 PM, Jason Dillaman <jdillama@redhat.com> wrote:
> >> Are you referring to rbd_default_features [1]? If so, that was a
> >> change with unintentional consequences in the master branch that I
> >> will need to fix before the final Kraken release.
> >>
> >> [1] https://github.com/openstack/cinder/blob/9fcb3bf1ad00913654872858d0cec839a6a2f0c8/cinder/volume/drivers/rbd.py#L152
> >>
> >> On Tue, Dec 13, 2016 at 3:29 PM, Victor Denisov <vdenisov@mirantis.com> wrote:
> >>> Hello,
> >>>
> >>> Who knows where pybind/rados/rados.pyx came from?
> >>> I talked to a guy in the cinder development team - he tried to build
> >>> his code against the latest python bindings from master.
> >>> It looks like the api's changed. Rados.conf_get('features') used to
> >>> return an integer.
> >>> It returns a string right now.
> >>>
> >>> I looked into the git history and I see that pybind.pyx has been where
> >>> it's right now only since February this year. I presume cinder's using
> >>> an older version.
> >>>
> >>> Can someone advise me on how I can track down the changes in python bindings.
> >>>
> >>> Thank you in advance.
> >>>
> >>> Victor.
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >>> the body of a message to majordomo@vger.kernel.org
> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >>
> >>
> >> --
> >> Jason
> 
> 
> 
> -- 
> Jason
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Mykola Golub
