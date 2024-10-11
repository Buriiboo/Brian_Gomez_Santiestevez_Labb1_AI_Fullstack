import streamlit as st
from utils.query_database import QueryDatabase

class ContentKPI:
    def __init__(self) -> None:
        self._content = QueryDatabase("SELECT * FROM marts.content_view_time;").df

    def display_content(self):
        df = self._content
        st.markdown("## KPIer för videor")
        st.markdown("Nedan visas KPIer för totalt antal")

        kpis = {
            "videor": len(df),
            "visade timmar": df["Visningstid_timmar"].sum(),
            "prenumeranter": df["Prenumeranter"].sum(),
            "exponeringar": df["Exponeringar"].sum(),
        }

        for col, kpi in zip(st.columns(len(kpis)), kpis):
            with col: 
                st.metric(kpi, round(kpis[kpi]))
        st.dataframe(df)

# create more KPIs here
import streamlit as st
from utils.query_database import QueryDatabase

class ViewsKPI:
    def __init__(self) -> None:
        self._views_visningar = QueryDatabase("SELECT * FROM marts.video_visningar_sorterade;").df
        self._views_mest_sedda = QueryDatabase("SELECT * FROM marts.videor_med_hoga_visningar;").df
        self._views_null_statistik = QueryDatabase("SELECT * FROM marts.null_raknare_statistik;").df

    def display_content(self):
        st.title("Views KPI Dashboard")

        # Display the data from video_visningar_sorterade
        st.markdown("## Video Visningar Sorterade")
        if not self._views_visningar.empty:
            st.dataframe(self._views_visningar)
            st.markdown("### KPIer för Videor Sorterade efter Visningar")

            # Display key metrics for video_visningar_sorterade
            total_videos = len(self._views_visningar)
            total_views = self._views_visningar['Visningar'].sum()
            avg_views_per_video = round(total_views / total_videos, 2)

            # Display KPI metrics
            st.metric("Totalt Antal Videor", total_videos)
            st.metric("Totalt Antal Visningar", total_views)
            st.metric("Genomsnittligt Antal Visningar per Video", avg_views_per_video)

        else:
            st.warning("No data available in 'marts.video_visningar_sorterade'.")

        # Display the data from videor_med_hoga_visningar
        st.markdown("## Videor med Mer än 50 Visningar")
        if not self._views_mest_sedda.empty:
            st.dataframe(self._views_mest_sedda)
            st.markdown("### KPIer för Mest Sedda Videor")

            # Display key metrics for videor_med_hoga_visningar
            total_high_view_videos = len(self._views_mest_sedda)
            highest_view_count = self._views_mest_sedda['Visningar'].max()
            most_viewed_video = self._views_mest_sedda.loc[self._views_mest_sedda['Visningar'].idxmax(), 'Videotitel']

            # Display KPI metrics
            st.metric("Totalt Antal Videor med Mer än 50 Visningar", total_high_view_videos)
            st.metric("Högsta Antal Visningar", highest_view_count)
            st.metric("Mest Sedda Video", most_viewed_video)

        else:
            st.warning("No data available in 'marts.videor_med_hoga_visningar'.")

        # Display the data from null_raknare_statistik
        st.markdown("## Statistik över Null- och Icke-Null-Värden")
        if not self._views_null_statistik.empty:
            st.dataframe(self._views_null_statistik)
            st.markdown("### KPIer för Null- och Icke-Null-Värden")

            # Extract metrics from null_raknare_statistik
            total_rows = self._views_null_statistik['totala_rader'].iloc[0]
            non_null_titles = self._views_null_statistik['icke_null_titlar'].iloc[0]
            non_null_views = self._views_null_statistik['icke_null_visningar'].iloc[0]

            # Display KPI metrics
            st.metric("Totalt Antal Rader", total_rows)
            st.metric("Antal Icke-Null Videotitlar", non_null_titles)
            st.metric("Antal Icke-Null Visningar", non_null_views)
        else:
            st.warning("No data available in 'marts.null_raknare_statistik'.")

# Create an instance of the ViewsKPI class and display the KPIs
views_kpi = ViewsKPI()
views_kpi.display_content()
