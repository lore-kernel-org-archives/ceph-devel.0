From: Alfredo Deza <adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: download.ceph.com repository changes
Date: Tue, 24 Jul 2018 10:59:09 -0400
Message-ID: <CAC-Np1zcjxnSJ9Ph6PQjHQytnMqAO=3Ws_5b6Ayw03m-BNi6CA@mail.gmail.com>
References: <CAC-Np1zTk1G-LF3eJiqzSF8SS=h=Jrr261C4vHdgmmwcqhUeXQ@mail.gmail.com>
 <CABZ+qqmWyu8THMnLRjDdvnsuYS6OV4-f7b_fFomfxOVFhZjsVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CABZ+qqmWyu8THMnLRjDdvnsuYS6OV4-f7b_fFomfxOVFhZjsVQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Dan van der Ster <dan-EOCVfBHj35C+XT7JhA+gdA@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org" <ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Tue, Jul 24, 2018 at 10:54 AM, Dan van der Ster <dan-EOCVfBHj35C+XT7JhA+gdA@public.gmane.org> wrote:
> On Tue, Jul 24, 2018 at 4:38 PM Alfredo Deza <adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
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
>
> What we did with our mirror was: `rm -f *12.2.6*; createrepo --update
> .` Took a few seconds. Then disabled the mirror cron.

Up until next time when we cut another release and you have to
re-enable the mirror with 12.2.6 in it :(

This is also fast for RPM repos, but not quite fast for DEB repos.
Finally, *if* you are doing this, the metadata changes, and the repos
need to
be signed again. I am curious how that --update operation didn't make
installations complain

>
> -- Dan
>
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
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
