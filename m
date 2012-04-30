From: Samuel Just <sam.just@dreamhost.com>
Subject: Re: Re-replicated data does not seem to get uniformly redistributed
 after OSD failure
Date: Mon, 30 Apr 2012 10:12:08 -0700
Message-ID: <CACLRD_2ddyK_GCM24fiTcyQGigJMJLD=8x-XwDb0wYcNDH-1Hg@mail.gmail.com>
References: <4F987D40.8040101@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:41438 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753988Ab2D3RMJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Apr 2012 13:12:09 -0400
Received: by wejx9 with SMTP id x9so1934372wej.19
        for <ceph-devel@vger.kernel.org>; Mon, 30 Apr 2012 10:12:08 -0700 (PDT)
In-Reply-To: <4F987D40.8040101@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

There is a (unfortunately non-optional at the moment) feature in crush
where we retry in the same bucket a few times before restarting the
descent when hitting an out leaf.  The result of this is to localise
recovery at the expense of inadequately redistributing data on node
failure.  We will most likely remove this behaviour in the next crush
version.
-Sam

On Wed, Apr 25, 2012 at 3:40 PM, Jim Schutt <jaschut@sandia.gov> wrote:
> Hi,
>
> I've been experimenting with failure scenarios to make sure
> I understand what happens when an OSD drops out. =C2=A0In particular,
> I've been using "ceph osd out <n>" and watching my all my OSD
> servers to see where the data from the removed OSD ends up
> after recovery. =C2=A0I've been doing this testing with 12 servers,
> 24 OSDs/server.
>
> What I see is that all the data from the removed OSD seem to
> end up distributed across the other OSDs on the host holding
> the removed OSD.
>
> It works this way if I use the default CRUSH map generated
> for just host buckets and devices, i.e. a map using the
> straw algorithm for the root and host buckets. =C2=A0It also
> works this way if I generate my own map using the uniform
> algorithm for the root and host buckets.
>
> For example, using my map based on the uniform algorithm,
> after successively taking out osd.0 thru osd.9 (all on
> host cs32), here's the top 24 OSD data store usage:
>
> Host =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1K-blocks =C2=A0 =C2=A0 =C2=A0=
Used Available Use% Mounted on
>
> cs39: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0942180120 =C2=A033379144 8711=
14904 =C2=A0 4% /ram/mnt/ceph/data.osd.174
> cs39: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0942180120 =C2=A033386420 8711=
06604 =C2=A0 4% /ram/mnt/ceph/data.osd.186
> cs43: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0942180120 =C2=A033484704 8710=
08448 =C2=A0 4% /ram/mnt/ceph/data.osd.270
> cs43: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0942180120 =C2=A033563912 8709=
30616 =C2=A0 4% /ram/mnt/ceph/data.osd.267
> cs38: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0942180120 =C2=A033637652 8708=
56876 =C2=A0 4% /ram/mnt/ceph/data.osd.162
> cs34: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0942180120 =C2=A033773780 8707=
21740 =C2=A0 4% /ram/mnt/ceph/data.osd.67
> cs37: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0942180120 =C2=A033834584 8706=
60136 =C2=A0 4% /ram/mnt/ceph/data.osd.123
> cs40: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0942180120 =C2=A033936696 8705=
57928 =C2=A0 4% /ram/mnt/ceph/data.osd.203
> cs38: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0942180120 =C2=A034212020 8702=
83404 =C2=A0 4% /ram/mnt/ceph/data.osd.165
> cs42: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0942180120 =C2=A034402852 8700=
95036 =C2=A0 4% /ram/mnt/ceph/data.osd.259
> cs32: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0942180120 =C2=A045969104 8585=
67088 =C2=A0 6% /ram/mnt/ceph/data.osd.17
> cs32: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0942180120 =C2=A049694156 8548=
54196 =C2=A0 6% /ram/mnt/ceph/data.osd.16
> cs32: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0942180120 =C2=A050182636 8543=
70356 =C2=A0 6% /ram/mnt/ceph/data.osd.15
> cs32: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0942180120 =C2=A050520484 8540=
30460 =C2=A0 6% /ram/mnt/ceph/data.osd.12
> cs32: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0942180120 =C2=A050669280 8538=
82848 =C2=A0 6% /ram/mnt/ceph/data.osd.10
> cs32: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0942180120 =C2=A051234372 8533=
19452 =C2=A0 6% /ram/mnt/ceph/data.osd.14
> cs32: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0942180120 =C2=A051277080 8532=
76808 =C2=A0 6% /ram/mnt/ceph/data.osd.22
> cs32: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0942180120 =C2=A051279984 8532=
73392 =C2=A0 6% /ram/mnt/ceph/data.osd.13
> cs32: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0942180120 =C2=A052364512 8521=
92000 =C2=A0 6% /ram/mnt/ceph/data.osd.23
> cs32: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0942180120 =C2=A052376512 8521=
80384 =C2=A0 6% /ram/mnt/ceph/data.osd.21
> cs32: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0942180120 =C2=A053026724 8515=
31228 =C2=A0 6% /ram/mnt/ceph/data.osd.18
> cs32: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0942180120 =C2=A053217832 8513=
43128 =C2=A0 6% /ram/mnt/ceph/data.osd.20
> cs32: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0942180120 =C2=A053723152 8508=
38768 =C2=A0 6% /ram/mnt/ceph/data.osd.19
> cs32: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0942180120 =C2=A056159652 8484=
10460 =C2=A0 7% /ram/mnt/ceph/data.osd.11
>
> I was thinking that CRUSH would re-replicate considering all
> buckets, subject to preventing multiple replicas in the same
> bucket, based on this from Sage's thesis, section 5.2.2.1:
>
> =C2=A0 For failed or overloaded devices, CRUSH uniformly
> =C2=A0 redistributes items across the storage cluster by
> =C2=A0 restarting the recursion at the beginning of the
> =C2=A0 select(n,t) (see Algorithm 1 line 11).
>
> So my question is, what am I missing? =C2=A0Maybe the above doesn't
> mean what I think it does? =C2=A0Or, is there some configuration
> that I should be using but don't know about?
>
> Thanks -- Jim
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
