From: Dan Mick <dmick@redhat.com>
Subject: Re: [ceph-users] Re: v15.2.4 Octopus released
Date: Tue, 30 Jun 2020 18:03:49 -0700
Message-ID: <0c6fdac1-3ea7-7e73-3a93-73c80de3e93a@redhat.com>
References: <d21c2b58-1191-5e5f-3df1-a84d42750b48@redhat.com>
 <CALi_L4_4ZqX1d7Xa1a8qpRfjHnyvUtj81vr0PGiUE8nmSGwMig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47341 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725805AbgGABEA (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Jun 2020 21:04:00 -0400
Received: by mail-pl1-f198.google.com with SMTP id q19so13161774pls.7
        for <ceph-devel@vger.kernel.org>; Tue, 30 Jun 2020 18:03:55 -0700 (PDT)
In-Reply-To: <CALi_L4_4ZqX1d7Xa1a8qpRfjHnyvUtj81vr0PGiUE8nmSGwMig@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sasha Litvak <alexander.v.litvak@gmail.com>, David Galloway <dgallowa@redhat.com>
Cc: ceph-announce@ceph.io, ceph-users <ceph-users@ceph.io>, dev@ceph.io, ceph-devel <ceph-devel@vger.kernel.org>, ceph-maintainers@ceph.io

True.  That said, the blog post points to 
http://download.ceph.com/tarballs/ where all the tarballs, including 
15.2.4, live.

  On 6/30/2020 5:57 PM, Sasha Litvak wrote:
> David,
> 
> Download link points to 14.2.10 tarball.
> 
> On Tue, Jun 30, 2020, 3:38 PM David Galloway <dgallowa@redhat.com> wrote:
> 
>> We're happy to announce the fourth bugfix release in the Octopus series.
>> In addition to a security fix in RGW, this release brings a range of fixes
>> across all components. We recommend that all Octopus users upgrade to this
>> release. For a detailed release notes with links & changelog please
>> refer to the official blog entry at
>> https://ceph.io/releases/v15-2-4-octopus-released
>>
>> Notable Changes
>> ---------------
>> * CVE-2020-10753: rgw: sanitize newlines in s3 CORSConfiguration's
>> ExposeHeader
>>    (William Bowling, Adam Mohammed, Casey Bodley)
>>
>> * Cephadm: There were a lot of small usability improvements and bug fixes:
>>    * Grafana when deployed by Cephadm now binds to all network interfaces.
>>    * `cephadm check-host` now prints all detected problems at once.
>>    * Cephadm now calls `ceph dashboard set-grafana-api-ssl-verify false`
>>      when generating an SSL certificate for Grafana.
>>    * The Alertmanager is now correctly pointed to the Ceph Dashboard
>>    * `cephadm adopt` now supports adopting an Alertmanager
>>    * `ceph orch ps` now supports filtering by service name
>>    * `ceph orch host ls` now marks hosts as offline, if they are not
>>      accessible.
>>
>> * Cephadm can now deploy NFS Ganesha services. For example, to deploy NFS
>> with
>>    a service id of mynfs, that will use the RADOS pool nfs-ganesha and
>> namespace
>>    nfs-ns::
>>
>>      ceph orch apply nfs mynfs nfs-ganesha nfs-ns
>>
>> * Cephadm: `ceph orch ls --export` now returns all service specifications
>> in
>>    yaml representation that is consumable by `ceph orch apply`. In addition,
>>    the commands `orch ps` and `orch ls` now support `--format yaml` and
>>    `--format json-pretty`.
>>
>> * Cephadm: `ceph orch apply osd` supports a `--preview` flag that prints a
>> preview of
>>    the OSD specification before deploying OSDs. This makes it possible to
>>    verify that the specification is correct, before applying it.
>>
>> * RGW: The `radosgw-admin` sub-commands dealing with orphans --
>>    `radosgw-admin orphans find`, `radosgw-admin orphans finish`, and
>>    `radosgw-admin orphans list-jobs` -- have been deprecated. They have
>>    not been actively maintained and they store intermediate results on
>>    the cluster, which could fill a nearly-full cluster.  They have been
>>    replaced by a tool, currently considered experimental,
>>    `rgw-orphan-list`.
>>
>> * RBD: The name of the rbd pool object that is used to store
>>    rbd trash purge schedule is changed from "rbd_trash_trash_purge_schedule"
>>    to "rbd_trash_purge_schedule". Users that have already started using
>>    `rbd trash purge schedule` functionality and have per pool or namespace
>>    schedules configured should copy "rbd_trash_trash_purge_schedule"
>>    object to "rbd_trash_purge_schedule" before the upgrade and remove
>>    "rbd_trash_purge_schedule" using the following commands in every RBD
>>    pool and namespace where a trash purge schedule was previously
>>    configured::
>>
>>      rados -p <pool-name> [-N namespace] cp rbd_trash_trash_purge_schedule
>> rbd_trash_purge_schedule
>>      rados -p <pool-name> [-N namespace] rm rbd_trash_trash_purge_schedule
>>
>>    or use any other convenient way to restore the schedule after the
>>    upgrade.
>>
>> Getting Ceph
>> ------------
>> * Git at git://github.com/ceph/ceph.git
>> * Tarball at http://download.ceph.com/tarballs/ceph-14.2.10.tar.gz
>> * For packages, see http://docs.ceph.com/docs/master/install/get-packages/
>> * Release git sha1: 7447c15c6ff58d7fce91843b705a268a1917325c
>>
>> --
>> David Galloway
>> Systems Administrator, RDU
>> Ceph Engineering
>> IRC: dgalloway
>> _______________________________________________
>> Dev mailing list -- dev@ceph.io
>> To unsubscribe send an email to dev-leave@ceph.io
>>
> _______________________________________________
> ceph-users mailing list -- ceph-users@ceph.io
> To unsubscribe send an email to ceph-users-leave@ceph.io
> 
