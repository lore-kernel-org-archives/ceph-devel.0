From: Abhishek Lekshmanan <abhishek-IBi9RG/b67k@public.gmane.org>
Subject: Re: download.ceph.com repository changes
Date: Tue, 17 Sep 2019 15:33:56 +0200
Message-ID: <87h85bcaij.fsf@suse.com>
References: <CAC-Np1zTk1G-LF3eJiqzSF8SS=h=Jrr261C4vHdgmmwcqhUeXQ@mail.gmail.com> <CAC-Np1zjZJW2iqLVe720u_sxQDTKjoUqL9ftrqKbMcYbZQgYFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-a8pt6IJUokc@public.gmane.org>
In-Reply-To: <CAC-Np1zjZJW2iqLVe720u_sxQDTKjoUqL9ftrqKbMcYbZQgYFQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Archive: <https://lists.ceph.io/hyperkitty/list/ceph-users-a8pt6IJUokc@public.gmane.org/>
List-Help: <mailto:ceph-users-request-a8pt6IJUokc@public.gmane.org?subject=help>
List-Post: <mailto:ceph-users-a8pt6IJUokc@public.gmane.org>
List-Subscribe: <mailto:ceph-users-join-a8pt6IJUokc@public.gmane.org>
List-Unsubscribe: <mailto:ceph-users-leave-a8pt6IJUokc@public.gmane.org>
To: Alfredo Deza <adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "ceph-maintainers@ceph.com" <ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org>, ceph-users <ceph-users-a8pt6IJUokc@public.gmane.org>, Abhishek Lekshmanan <abhishek.lekshmanan-IBi9RG/b67k@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

"Alfredo Deza" <adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> writes:

> Reviving this old thread.
>
> I still think this is something we should consider as users still
> experience problems:
>
> * Impossible to 'pin' to a version. User installs 14.2.0 and 4 months
> later they add other nodes but version moved to 14.2.2
> * Impossible to use a version that is not what the latest is (e.g. if
> someone doesn't need the release from Monday, but wants the one from 6
> months ago), similar to the above
> * When a release is underway, the repository breaks because syncing
> packages takes hours. The operation is not atomic.

One of the main problems is the non atomicity here, so one way would be
that we announce we're building and syncing packages and the release
should be out soon, the main problem then is that this process can vary
between hours to a couple of days (or if it's a fri. longer).

> * It is not currently possible to "remove" a bad release, in the past,
> this means cutting a new release as soon as possible, which can take
> days
>
> The latest issue (my fault!) was to cut a release and get the packages
> out without communicating with the release manager, which caused users
> to note there is a new version *as soon as it was up* vs, a
> process that could've not touched the 'latest' url until the
> announcement goes out.
>
> If you have been affected by any of these issues (or others I didn't
> come up with), please let us know in this thread so that we can find
> some common ground and try to improve the process.
>
> Thanks!
>
> On Tue, Jul 24, 2018 at 10:38 AM Alfredo Deza <adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>>
>> Hi all,
>>
>> After the 12.2.6 release went out, we've been thinking on better ways
>> to remove a version from our repositories to prevent users from
>> upgrading/installing a known bad release.
>>
>> The way our repos are structured today means every single version of
>> the release is included in the repository. That is, for Luminous,
>> every 12.x.x version of the binaries is in the same repo. This is true
>> for both RPM and DEB repositories.
>>
>> However, the DEB repos don't allow pinning to a given version because
>> our tooling (namely reprepro) doesn't construct the repositories in a
>> way that this is allowed. For RPM repos this is fine, and version
>> pinning works.
>>
>> To remove a bad version we have to proposals (and would like to hear
>> ideas on other possibilities), one that would involve symlinks and the
>> other one which purges the known bad version from our repos.
>>
>> *Symlinking*
>> When releasing we would have a "previous" and "latest" symlink that
>> would get updated as versions move forward. It would require
>> separation of versions at the URL level (all versions would no longer
>> be available in one repo).
>>
>> The URL structure would then look like:
>>
>>     debian/luminous/12.2.3/
>>     debian/luminous/previous/  (points to 12.2.5)
>>     debian/luminous/latest/   (points to 12.2.7)
>>
>> Caveats: the url structure would change from debian-luminous/ to
>> prevent breakage, and the versions would be split. For RPMs it would
>> mean a regression if someone is used to pinning, for example pinning
>> to 12.2.2 wouldn't be possible using the same url.
>>
>> Pros: Faster release times, less need to move packages around, and
>> easier to remove a bad version
>>
>>
>> *Single version removal*
>> Our tooling would need to go and remove the known bad version from the
>> repository, which would require to rebuild the repository again, so
>> that the metadata is updated with the difference in the binaries.
>>
>> Caveats: time intensive process, almost like cutting a new release
>> which takes about a day (and sometimes longer). Error prone since the
>> process wouldn't be the same (one off, just when a version needs to be
>> removed)
>>
>> Pros: all urls for download.ceph.com and its structure are kept the same.
> _______________________________________________
> ceph-users mailing list -- ceph-users-a8pt6IJUokc@public.gmane.org
> To unsubscribe send an email to ceph-users-leave-a8pt6IJUokc@public.gmane.org
>

-- 
Abhishek 
_______________________________________________
ceph-users mailing list -- ceph-users-a8pt6IJUokc@public.gmane.org
To unsubscribe send an email to ceph-users-leave-a8pt6IJUokc@public.gmane.org
