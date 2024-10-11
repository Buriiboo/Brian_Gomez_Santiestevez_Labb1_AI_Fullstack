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

class ViewsKPI:
    def __init__(self) -> None:
        available_tables = QueryDatabase("SELECT table_name FROM information_schema.tables WHERE table_schema = 'marts';").df
        print("Available tables in 'marts':", available_tables)

        if 'content_view_time' in available_tables['table_name'].values:
            self._views = QueryDatabase("SELECT * FROM marts.content_view_time;").df
        else:
            st.error("The table 'marts.content_view_time' does not exist! Please check your schema or create the table.")
            self._views = None

    def display_content(self):
        if self._views is not None:
            st.markdown("## KPIer för Videor")
            st.markdown("Nedan visas KPIer för totalt antal visningar och visningstid.")
            
            # Display KPI metrics
            kpis = {
                "videor": len(self._views),
                "visade timmar": self._views["Visningstid_timmar"].sum(),
                "prenumeranter": self._views["Prenumeranter"].sum(),
                "exponeringar": self._views["Exponeringar"].sum(),
            }

            for col, kpi in zip(st.columns(len(kpis)), kpis):
                with col:
                    st.metric(kpi, round(kpis[kpi]))

            st.dataframe(self._views)
        else:
            st.warning("No data available to display for 'marts.content_view_time'.")