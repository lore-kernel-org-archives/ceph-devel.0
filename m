From: Lorieri <lorieri@gmail.com>
Subject: Re: radosgw S3 api
Date: Wed, 14 Aug 2013 20:34:40 -0300
Message-ID: <CAPHxCcTij29h0AMBno=MHcKtcmEfPtc6vkx6B=B2qP1-zJiEjg@mail.gmail.com>
References: <CAPHxCcSX7CRS2+-CWA7hGYAZKSm2PDn+hYd6+EtqHtSm+8fN3w@mail.gmail.com>
	<CAC-hyiEzLgZ6LKt2hX43Ac9xWUETz0CP_XzL77aaFx6M+=JheA@mail.gmail.com>
	<CAPHxCcQMLmBinmk88xGC6Fd02H2MyjDL3Ey063oh++8VmAW6Tg@mail.gmail.com>
	<CAC-hyiECy_LOQjhaeX=k1zC5bT_MAn6e4Nq7emLCNkvXh_xJkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:55005 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758139Ab3HNXel (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Aug 2013 19:34:41 -0400
Received: by mail-pd0-f172.google.com with SMTP id z10so105176pdj.31
        for <ceph-devel@vger.kernel.org>; Wed, 14 Aug 2013 16:34:40 -0700 (PDT)
In-Reply-To: <CAC-hyiECy_LOQjhaeX=k1zC5bT_MAn6e4Nq7emLCNkvXh_xJkQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel@vger.kernel.org

for the records:

radosgw-admin key create --gen-secret --subuser=myuser:swift --key-type=swift
git clone https://github.com/openstack/python-swiftclient.git
cd python-swiftclient
python setup.py install
swift -v -A http://mycluster/auth/v1.0 -U myuser:swift
--key='xxxxxxxxx' post mybucket -r .r:*


On Thu, Mar 28, 2013 at 1:41 AM, Yehuda Sadeh <yehuda@inktank.com> wrote:
>
> On Wed, Mar 27, 2013 at 9:32 PM, Lorieri <lorieri@gmail.com> wrote:
> > great!
> > I will try this.
> > Will it affect objects later put through S3 api ?
>
> Yes. It sets a flag on the bucket, and reads through the S3 api will
> be the same as through the Swift api. It's just not possible to set
> that flag via the S3 api.
>
> Yehuda
>
> >
> >
> > On Wed, Mar 27, 2013 at 11:12 PM, Yehuda Sadeh <yehuda@inktank.com>
> > wrote:
> >>
> >> On Wed, Mar 27, 2013 at 4:03 PM, Lorieri <lorieri@gmail.com> wrote:
> >> > Hi,
> >> >
> >> > There is a behavior in AWS S3 I could not reproduce in radosgw.
> >> >
> >> > If you create an empty bucket and makes it public, any object you put
> >> > there will be public too, and will automatically be possible to
> >> > access
> >> > it by its http url.
> >> > It is very helpful when people use some tools and browsers plugins to
> >> > upload content or do a bulk sync.
> >> >
> >> > am I missing something ?
> >>
> >> The S3 ACLs don't allow that. Amazon provides a different orthogonal
> >> scheme (bucket policies) that we don't support and that makes it
> >> possible.
> >> With the rados gateway you can achieve that if you're using the swift
> >> api and setting the bucket public through it.
> >>
> >>
> >> Yehuda
> >
> >
