From: "Brent Kennedy" <bkennedy-3tLf1voIkJTQT0dZR+AlfA@public.gmane.org>
Subject: Re: download.ceph.com repository changes
Date: Tue, 24 Jul 2018 13:19:23 -0400
Message-ID: <009801d42372$7acb6160$70622420$@cfl.rr.com>
References: <CAC-Np1zTk1G-LF3eJiqzSF8SS=h=Jrr261C4vHdgmmwcqhUeXQ@mail.gmail.com>
 <CABZ+qqmWyu8THMnLRjDdvnsuYS6OV4-f7b_fFomfxOVFhZjsVQ@mail.gmail.com>
 <CAC-Np1zcjxnSJ9Ph6PQjHQytnMqAO=3Ws_5b6Ayw03m-BNi6CA@mail.gmail.com>
 <CABZ+qq=4Tdur7=8mFLb3XO_T-NcJPpJLpL4ysSHbsLN3OU3iig@mail.gmail.com>
 <CABZ+qqmv7VnMcKMSPjQCNVCHypMvZYfb1D6vy+dLRGQiAcKwQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CABZ+qqmv7VnMcKMSPjQCNVCHypMvZYfb1D6vy+dLRGQiAcKwQw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-us
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: 'Dan van der Ster' <dan-EOCVfBHj35C+XT7JhA+gdA@public.gmane.org>, 'Alfredo Deza' <adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: 'ceph-users' <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

It would be nice if ceph-deploy could select the version as well as the
release.  E.G:  --release luminous --version 12.2.7   

Otherwise, I deploy a newest release to a new OSD server, then have to
upgrade the rest of the cluster ( unless the cluster is on a previous
release at the highest level )

Not sure if this adds to this particular discussion though :)

-Brent

-----Original Message-----
From: ceph-users [mailto:ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org] On Behalf Of Dan
van der Ster
Sent: Tuesday, July 24, 2018 11:26 AM
To: Alfredo Deza <adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>; ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org
Subject: Re: [ceph-users] download.ceph.com repository changes

On Tue, Jul 24, 2018 at 5:08 PM Dan van der Ster <dan-EOCVfBHj35C+XT7JhA+gdA@public.gmane.org> wrote:
>
> On Tue, Jul 24, 2018 at 4:59 PM Alfredo Deza <adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> >
> > On Tue, Jul 24, 2018 at 10:54 AM, Dan van der Ster <dan-EOCVfBHj35C+XT7JhA+gdA@public.gmane.org>
wrote:
> > > On Tue, Jul 24, 2018 at 4:38 PM Alfredo Deza <adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> > >>
> > >> Hi all,
> > >>
> > >> After the 12.2.6 release went out, we've been thinking on better 
> > >> ways to remove a version from our repositories to prevent users 
> > >> from upgrading/installing a known bad release.
> > >>
> > >> The way our repos are structured today means every single version 
> > >> of the release is included in the repository. That is, for 
> > >> Luminous, every 12.x.x version of the binaries is in the same 
> > >> repo. This is true for both RPM and DEB repositories.
> > >>
> > >> However, the DEB repos don't allow pinning to a given version 
> > >> because our tooling (namely reprepro) doesn't construct the 
> > >> repositories in a way that this is allowed. For RPM repos this is 
> > >> fine, and version pinning works.
> > >>
> > >> To remove a bad version we have to proposals (and would like to 
> > >> hear ideas on other possibilities), one that would involve 
> > >> symlinks and the other one which purges the known bad version from
our repos.
> > >
> > > What we did with our mirror was: `rm -f *12.2.6*; createrepo 
> > > --update .` Took a few seconds. Then disabled the mirror cron.
> >
> > Up until next time when we cut another release and you have to 
> > re-enable the mirror with 12.2.6 in it :(
> >
>
> Right... we re-sync'd 12.2.6 along with 12.2.7 -- but people here 
> mostly grab the highest version.
>
> > This is also fast for RPM repos, but not quite fast for DEB repos.
> > Finally, *if* you are doing this, the metadata changes, and the 
> > repos need to be signed again. I am curious how that --update 
> > operation didn't make installations complain
>
> Good question.. I don't know enough about the repo signatures to 
> comment on this.

I asked our mirror man. Apparently we don't sign the repo, only the rpms. So
not applicable in general I suppose.

Another completely different (and not my) idea, how about we retag the last
good release with z+1. In this case we had 12.2.5 as the last good, and
12.2.6 broken, so we add the v12.2.7 tag on v12.2.5, effectively re-pushing
12.2.5 to the top.

-- dan

> I do know that all clients who had distro-sync'd up to 12.2.6 
> successfully distro-sync'd back to 12.2.5.
> (Our client machines yum distro-sync daily).
>
> -- Dan
>
> >
> > >
> > > -- Dan
> > >
> > >>
> > >> *Symlinking*
> > >> When releasing we would have a "previous" and "latest" symlink 
> > >> that would get updated as versions move forward. It would require 
> > >> separation of versions at the URL level (all versions would no 
> > >> longer be available in one repo).
> > >>
> > >> The URL structure would then look like:
> > >>
> > >>     debian/luminous/12.2.3/
> > >>     debian/luminous/previous/  (points to 12.2.5)
> > >>     debian/luminous/latest/   (points to 12.2.7)
> > >>
> > >> Caveats: the url structure would change from debian-luminous/ to 
> > >> prevent breakage, and the versions would be split. For RPMs it 
> > >> would mean a regression if someone is used to pinning, for 
> > >> example pinning to 12.2.2 wouldn't be possible using the same url.
> > >>
> > >> Pros: Faster release times, less need to move packages around, 
> > >> and easier to remove a bad version
> > >>
> > >>
> > >> *Single version removal*
> > >> Our tooling would need to go and remove the known bad version 
> > >> from the repository, which would require to rebuild the 
> > >> repository again, so that the metadata is updated with the difference
in the binaries.
> > >>
> > >> Caveats: time intensive process, almost like cutting a new 
> > >> release which takes about a day (and sometimes longer). Error 
> > >> prone since the process wouldn't be the same (one off, just when 
> > >> a version needs to be
> > >> removed)
> > >>
> > >> Pros: all urls for download.ceph.com and its structure are kept the
same.
> > >> --
> > >> To unsubscribe from this list: send the line "unsubscribe 
> > >> ceph-devel" in the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org 
> > >> More majordomo info at  
> > >> http://vger.kernel.org/majordomo-info.html
_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
